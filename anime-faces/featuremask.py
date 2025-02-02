from PIL import Image, ImageFilter
import numpy as np
import os, sys

base_name = ["ottd", "mgr"]

def mask_features(feature, source, root_dir="."):
    if not os.path.exists(os.path.join(root_dir, "m")):
        os.mkdir(os.path.join(root_dir, "m"))
    base_name_string = []
    ethnicity = ["afr", "eur"]
    gender = ["wmn", "man"]
    for ethnicitya in ethnicity:
        for gendera in gender:
            base_name_string.append("_".join(base_name + [gendera, ethnicitya, source]))
    print(feature, source, base_name_string)
    # all files with basename in base directory
    for base in base_name_string:
        files = [f for f in os.listdir(os.path.join(root_dir)) if f.startswith(base)]
        for file in files:
            img = Image.open(file)
            out = file[:-4] + "_"+feature+".png"
            mask = Image.open(os.path.join(root_dir, feature+"_mask.png")).convert("RGBA")
            # normalise skin tone
            skin_tone_mask = Image.open(os.path.join(root_dir, "skintone_mask.png")).convert("RGBA")
            r, g, b, a = img.convert("RGBA").split()
            a = np.array(a)
            a = np.where(a < 128, 0, 1)
            r, g, b = img.convert("RGB").split()
            r, g, b = np.array(r), np.array(g), np.array(b)
            r, g, b = a * r, a * g, a * b
            rr, rg, rb = np.sum(r) / np.sum(a), np.sum(g) / np.sum(a), np.sum(b) / np.sum(a)
            if "_afr_" in base:
                tr, tg, tb = 155, 125, 111
            elif "_eur_" in base:
                tr, tg, tb = 224, 197, 184
            r, g, b, a = img.convert("RGBA").split()
            r, g, b = np.array(r), np.array(g), np.array(b)
            #r, g, b = r - rr + tr, g - rg + tg, b - rb + tb # additive, offset brightnes
            r, g, b = r * (tr / rr), g * (tg / rg), b * (tb / rb) # multiplicative, scale brightness
            r, g, b = np.clip(r, 0, 255), np.clip(g, 0, 255), np.clip(b, 0, 255)
            r, g, b = r.astype(np.uint8), g.astype(np.uint8), b.astype(np.uint8)
            r, g, b = Image.fromarray(r, 'L'), Image.fromarray(g, 'L'), Image.fromarray(b, 'L')
            img = Image.merge('RGBA', (r, g, b, a))
            # mask with alpha channel from mask image
            r, g, b, mask = mask.split()
            mask = np.array(mask)/255
            img = img.convert("RGBA")
            r, g, b, a = img.split()
            a = np.array(a)/255
            a = (mask * a)*255
            a = a.astype(np.uint8)
            a = Image.fromarray(a, 'L')
            img.putalpha(a)
            img.save(os.path.join(root_dir, "m", out))
            # for european eyes, also make a palmask
            if feature == "eyes" and "_eur_" in base:
                h, s, v = img.convert("HSV").split()
                h, s, v, a = np.array(h), np.array(s), np.array(v), np.array(a)
                # high-saturation blue regions (ie. eyes)
                h = np.where((h >= 110) & (h <= 180), 1, 0)
                s = np.where((s >= 80) & (s <= 255), 1, 0)
                v = np.where((v >= 30) & (v <= 255), 1, 0)
                a = np.where((a >= 128), 1, 0)
                mask = h & s & v & a
                # transparent blue, except for masked region which is a cc blue
                r = np.where(mask, 20, 0)
                g = np.where(mask, 52, 0)
                b = np.where(mask, 124, 255)
                r, g, b = r.astype(np.uint8), g.astype(np.uint8), b.astype(np.uint8)
                r, g, b = Image.fromarray(r, 'L'), Image.fromarray(g, 'L'), Image.fromarray(b, 'L')
                palmask = Image.merge('RGB', (r, g, b))
                palmask.save(os.path.join(root_dir, "m", out[:-4]+"_palmask.png"))

def process_faces(subdir, root_dir="."):
    scales = [1, 2, 4]
    for scale in scales:
        if not os.path.exists(os.path.join(root_dir, str(scale))):
            os.mkdir(os.path.join(root_dir, str(scale)))
    base_name_string = "_".join(base_name)
    # all files with basename in _p_ directory
    files = [os.path.join(root_dir, subdir, f) for f in os.listdir(os.path.join(root_dir, subdir)) if f.startswith(base_name_string) and f.endswith(".png")]
    print(subdir, base_name_string, files)
    base_size = (92, 119)
    input_scale = 8
    input_offset = (102, 29)
    for file in files:
        img = Image.open(os.path.join(file)).convert("RGBA")
        file_name = os.path.basename(file)
        img = img.crop((input_offset[0], input_offset[1], input_offset[0] + base_size[0]*input_scale, input_offset[1] + base_size[1]*input_scale))
        for scale in scales:
            print(file_name, scale)
            filter_radius = input_scale//scale + 1
            if "_glasses" in file_name:
                # slightly larger filter radius to retain clear outlines
                filter_radius = input_scale//scale + 3
            print(filter_radius, base_size[0]*scale, base_size[1]*scale)
            # min filter to retain clear outlines
            scaled_img = img.filter(ImageFilter.MinFilter())
            # max filter alpha channel to maintain outer outlines
            r, g, b, a = scaled_img.split()
            a = a.filter(ImageFilter.MaxFilter(filter_radius))
            # tidy alpha channel, scaling to crush low and high values
            crush_factor = 1.1
            a = np.array(a).astype(np.float32)
            a = (a - 128) * crush_factor + 128
            a = np.clip(a, 0, 255)
            a = a.astype(np.uint8)
            a = Image.fromarray(a, 'L')
            # re-merge with alpha
            scaled_img = Image.merge('RGBA', (r, g, b, a))
            # parse name, and shift hue based on skin tone
            magic_hue_shift = 0
            if "_afr_" in file_name:
                # slightly less red skin tone helps with dithering later
                magic_hue_shift = 40
            if "_eur_" in file_name:
                # slightly less yellow skin tone helps with dithering later
                magic_hue_shift = 0
            if magic_hue_shift != 0:
                print("shifting", magic_hue_shift)
                h, s, v = scaled_img.convert("HSV").split()
                h = np.array(h)
                h = (h + magic_hue_shift) % 256
                h = Image.fromarray(h, 'L')
                r, g, b, a_dummy = Image.merge('HSV', (h, s, v)).convert("RGBA").split()
                scaled_img = Image.merge('RGBA', (r, g, b, a))
            # resize to target size
            if file.endswith("_palmask.png"):
                scaled_img = scaled_img.resize((base_size[0]*scale, base_size[1]*scale), Image.NEAREST)
            else:
                scaled_img = scaled_img.resize((base_size[0]*scale, base_size[1]*scale))
            # save
            scaled_img.save(os.path.join(root_dir, str(scale), file_name))

def dither(img, palmask=None, dither_mode="sierra", max_error_propagation=64, max_alpha_error_propagation=255):
    openttd_palette = {
        "r": [0,16,32,48,64,80,100,116,132,148,168,184,200,216,232,252,52,68,88,108,132,156,176,204,48,64,80,96,120,148,176,204,72,88,104,124,152,184,212,244,64,88,112,136,160,188,204,220,236,252,252,252,252,76,96,116,136,156,176,196,68,96,128,156,184,212,232,252,252,252,32,64,84,108,128,148,168,184,196,212,8,16,32,48,64,84,104,128,28,44,60,80,104,128,152,180,16,32,56,76,96,120,152,184,32,56,72,88,104,124,140,160,76,96,116,136,164,184,204,212,224,236,80,100,120,140,160,184,36,48,64,80,100,132,172,212,40,64,88,104,120,140,160,188,0,0,0,0,0,24,56,88,128,188,16,24,40,52,80,116,156,204,172,212,252,252,252,252,252,252,72,92,112,140,168,200,208,232,60,92,128,160,196,224,252,252,252,252,252,252,252,252,204,228,252,252,252,252,8,12,20,28,40,56,72,100,92,108,124,144,224,200,180,132,88,244,245,246,247,248,249,250,251,252,253,254,255,76,108,144,176,210,252,252,252,252,252,252,252,64,255,48,64,80,255,32,36,40,44,48,72,100,216,96,68,255],
        "g": [0,16,32,48,64,80,100,116,132,148,168,184,200,216,232,252,60,76,96,116,140,160,184,208,44,60,76,92,120,148,176,204,44,60,80,104,132,160,188,220,0,4,16,32,56,84,104,132,156,188,208,232,252,40,60,88,116,136,156,180,24,44,68,96,120,156,184,212,248,252,4,20,28,44,56,72,92,108,128,148,52,64,80,96,112,132,148,168,52,68,88,104,124,148,176,204,52,72,96,116,136,164,192,220,24,28,40,52,64,84,108,128,40,52,68,84,96,112,128,148,168,188,28,40,56,76,100,136,40,52,64,80,100,132,172,212,20,44,64,76,88,104,136,168,24,36,52,72,96,120,144,168,196,224,64,80,96,112,140,172,204,240,52,52,52,100,144,184,216,244,20,44,68,100,136,176,184,208,0,0,0,0,0,0,0,80,108,136,164,192,220,252,136,144,156,176,196,216,24,36,52,68,92,120,152,172,156,176,200,224,244,236,220,188,152,0,0,0,0,0,0,0,0,0,0,0,0,24,44,72,108,146,60,84,104,124,148,172,196,0,0,48,64,80,255,68,72,76,80,84,100,132,244,128,96,255],
        "b": [255,16,32,48,64,80,100,116,132,148,168,184,200,216,232,252,72,92,112,132,152,172,196,220,4,12,20,28,64,100,132,168,4,20,44,72,92,120,148,176,4,16,32,52,76,108,124,144,164,192,0,60,128,0,8,28,56,80,108,136,0,4,8,16,24,32,16,0,128,192,0,8,16,28,40,56,76,88,108,128,0,0,4,4,12,20,28,44,24,32,48,60,76,92,108,124,24,44,72,88,108,136,168,200,0,0,4,12,24,44,64,88,16,24,40,56,64,80,96,112,128,148,4,20,40,64,96,136,68,84,100,116,136,164,192,224,112,144,172,196,224,252,252,252,108,132,160,184,212,220,232,240,252,252,96,108,120,132,160,192,220,252,52,52,52,88,124,160,200,236,112,140,168,196,224,248,255,252,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,4,0,48,100,152,88,104,124,140,164,188,216,224,52,64,76,92,252,248,236,216,172,244,245,246,247,248,249,250,251,252,253,254,255,8,24,52,84,126,0,0,0,0,0,0,0,0,0,0,0,0,0,112,116,120,124,128,144,168,252,164,140,255]
    }
    openttd_palette_animated = [227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,245,246,247,248,249,250,251,252,253,254,254]
    openttd_palette_generalmask = [0,255]
    openttd_color_set_start = [1, 16, 24, 32, 40, 50, 53, 60, 70, 80, 88, 96, 104, 112, 122, 128, 136, 144, 154, 162, 170, 178, 192, 198, 206]
    openttd_color_set_length = [15, 8, 8, 8, 10, 3, 7, 10, 10, 8, 8, 8, 8, 10, 6, 8, 8, 10, 8, 8, 8, 14, 6, 8, 4]
    colors_normal = [x for x in range(256) if x not in openttd_palette_animated]

    def put_openttd_palette(img):
        palette = []
        for i in range(256):
            palette.extend([openttd_palette["r"][i], openttd_palette["g"][i], openttd_palette["b"][i]])
        img.putpalette(palette)
        return img

    def most_similar_in_palette(pr, pg, pb):
      dist = 255 + 255 + 255
      index = 0
      for i in colors_normal:
        cd = abs(pr - openttd_palette["r"][i]) + abs(pg - openttd_palette["g"][i]) + abs(pb - openttd_palette["b"][i])
        if cd < dist:
          dist = cd
          index = i
      return index

    def most_similar_color_set(pr, pg, pb):
        index = most_similar_in_palette(pr, pg, pb)
        for i in range(len(openttd_color_set_start)):
            if index >= openttd_color_set_start[i] and index < openttd_color_set_start[i] + openttd_color_set_length[i]:
                return i
        return 255

    def most_similar_in_color_set(pr, pg, pb, color_set):
      dist = 255 + 255 + 255
      index = 0
      start_index = openttd_color_set_start[color_set]
      end_index = start_index + openttd_color_set_length[color_set]
      for i in range(start_index, end_index):
        cd = abs(pr - openttd_palette["r"][i]) + abs(pg - openttd_palette["g"][i]) + abs(pb - openttd_palette["b"][i])
        if cd < dist:
          dist = cd
          index = i
      return index

    # Dither settings
    if dither_mode == "sierra":
        # Sierra http://www.tannerhelland.com/4660/dithering-eleven-algorithms-source-code/
        dox = 2
        doy = 0
        df = 32
        da = [
            [-1, -1, -1,  5,  3],
            [ 2,  4,  5,  4,  2],
            [ 0,  2,  3,  2,  0]
        ]
    elif dither_mode == "sierra_lite":
        # Sierra lite http://www.tannerhelland.com/4660/dithering-eleven-algorithms-source-code/
        dox = 1
        doy = 0
        df = 4
        da = [
            [-1, -1,  2],
            [ 1,  1,  0]
        ]

    # Whether to _always_ dither within nearest set
    # Also used as the basis of palmask dithering
    dither_within_nearest_colour_set = False

    img = img.convert("RGBA")
    if dither_within_nearest_colour_set:
        # make nearest-neighbour colour set image
        nni = Image.new("L", img.size)
        for y in range(img.size[1]):
            for x in range(img.size[0]):
                pr, pg, pb, pa = img.getpixel((x, y))
                index = most_similar_color_set(pr, pg, pb)
                nni.putpixel((x, y), index)
    if palmask is not None:
        # make nearest-neighbour palmask image
        nni = Image.new("L", img.size)
        for y in range(img.size[1]):
            for x in range(img.size[0]):
                pr, pg, pb, pa = palmask.getpixel((x, y))
                index = most_similar_color_set(pr, pg, pb)
                nni.putpixel((x, y), index)
        dither_within_nearest_colour_set = True
    # make dithered
    out = Image.new("P", img.size)
    out = put_openttd_palette(out)
    for y in range(img.size[1]):
        for x in range(img.size[0]):
            pr, pg, pb, pa = img.getpixel((x, y))
            if pa == 0:
                # fast processing of transparent pixels
                out.putpixel((x, y), 0)
            else:
                if dither_within_nearest_colour_set:
                    # find closest colour set in palette
                    color_set = nni.getpixel((x, y))
                    if color_set == 255:
                        index = most_similar_in_palette(pr, pg, pb)
                    else:
                        # find closest colour in colour set
                        index = most_similar_in_color_set(pr, pg, pb, color_set)
                else:
                    # find closest colour in palette
                    index = most_similar_in_palette(pr, pg, pb)
                # set pixel, handling alpha and recording error
                if pa < 128:
                    # nearest neighbour based on alpha is transparent magic blue
                    index = 0
                    error = [0, 0, 0, pa]
                else:
                    # normal error calculation
                    error = [pr - openttd_palette["r"][index], pg - openttd_palette["g"][index], pb - openttd_palette["b"][index], pa - 255]
                out.putpixel((x, y), index)
                # calculate and propagate error
                for b in range(len(da)):
                    for a in range(len(da[0])):
                        if da[b][a] != -1 and x + a - dox < img.size[0] and y + b - doy < img.size[1]:
                            pr, pg, pb, pa = img.getpixel((x + a - dox, y + b - doy))
                            pr += int(error[0] * da[b][a] / df)
                            pg += int(error[1] * da[b][a] / df)
                            pb += int(error[2] * da[b][a] / df)
                            pa += int(error[3] * da[b][a] / df)
                            img.putpixel((x + a - dox, y + b - doy), (pr, pg, pb, pa))
                            # clamp propagated error to maximum
                            error[0] = max(-max_error_propagation, min(max_error_propagation, error[0]))
                            error[1] = max(-max_error_propagation, min(max_error_propagation, error[1]))
                            error[2] = max(-max_error_propagation, min(max_error_propagation, error[2]))
                            error[3] = max(-max_error_propagation, min(max_alpha_error_propagation, error[3]))

    palout = None
    if palmask is not None:
        palout = Image.new("P", palmask.size)
        palout = put_openttd_palette(palout)
        for y in range(img.size[1]):
            for x in range(img.size[0]):
                pr, pg, pb, pa = palmask.getpixel((x, y))
                if pr == 0 and pg == 0 and pb == 255:
                    palout.putpixel((x, y), 0)
                else:
                    color_set = most_similar_color_set(pr, pg, pb)
                    if color_set == 255:
                        palout.putpixel((x, y), 0)
                    else:
                        palout.putpixel((x, y), min(openttd_color_set_start[color_set] + openttd_color_set_length[color_set] // 2, 255))

    return out, palout

def make_8bpp(root_dir="."):
    scales = [1, 2, 4]
    for scale in scales:
        base_dir = os.path.join(root_dir, str(scale))
        files = [f for f in os.listdir(base_dir) if f.endswith(".png") and not f.endswith("_8bpp.png") and not f.endswith("_palmask.png")]
        for file in files:
            print(file)
            img = Image.open(os.path.join(base_dir, file))
            palmask = None
            if os.path.exists(os.path.join(base_dir, file[:-4]+"_palmask.png")):
                print("palmask found")
                palmask = Image.open(os.path.join(base_dir, file[:-4]+"_palmask.png"))
            img, palmask = dither(img, palmask)
            img.save(os.path.join(base_dir, file[:-4]+"_8bpp.png"))
            if palmask is not None:
                palmask.save(os.path.join(base_dir, file[:-4]+"_palmask_8bpp.png"))

def hue_cycle(root_dir="."):
    if not os.path.exists(os.path.join(root_dir, "h")):
        os.mkdir(os.path.join(root_dir, "h"))
    base_name_string = "_".join(base_name)
    suffixes = {
        "man_eur_shirtman": {
            "rgb_adjust": (1.0, 0.6, 0.6),
            "sat_override": 0.5,
            "val_adjust": 0.7,
        },
        "man_eur_tie": {
            "sat_override": 0.7,
            "val_adjust": 1.5,
        }
    }
    for suffix in suffixes:
        # all files with basename in _p_ directory
        files = [f for f in os.listdir(os.path.join(root_dir, "p")) if f.startswith(base_name_string+"_"+suffix) and f.endswith(".png")]
        for file in files:
            for i in range(0, 256, 32):
                img = Image.open(os.path.join(root_dir, "p", file))
                file_name = os.path.basename(file)
                r, g, b, a = img.convert("RGBA").split()
                if "rgb_adjust" in suffixes[suffix]:
                    r, g, b = np.array(r), np.array(g), np.array(b)
                    r = r * suffixes[suffix]["rgb_adjust"][0]
                    g = g * suffixes[suffix]["rgb_adjust"][1]
                    b = b * suffixes[suffix]["rgb_adjust"][2]
                    r, g, b = np.clip(r, 0, 255), np.clip(g, 0, 255), np.clip(b, 0, 255)
                    r, g, b = r.astype(np.uint8), g.astype(np.uint8), b.astype(np.uint8)
                    r, g, b = Image.fromarray(r, 'L'), Image.fromarray(g, 'L'), Image.fromarray(b, 'L')
                    img = Image.merge('RGBA', (r, g, b, a))
                h, s, v = img.convert("HSV").split()
                if "sat_override" in suffixes[suffix]:
                    s = np.array(s)
                    s.fill(suffixes[suffix]["sat_override"] * 255)
                    s = np.clip(s, 0, 255)
                    s = s.astype(np.uint8)
                    s = Image.fromarray(s, 'L')
                if "val_adjust" in suffixes[suffix]:
                    v = np.array(v)
                    v = v * suffixes[suffix]["val_adjust"]
                    v = np.clip(v, 0, 255)
                    v = v.astype(np.uint8)
                    v = Image.fromarray(v, 'L')
                h = np.array(h)
                h = (h + i) % 256
                h = h.astype(np.uint8)
                h = Image.fromarray(h, 'L')
                r, g, b, a_dummy = Image.merge('HSV', (h, s, v)).convert("RGBA").split()
                img = Image.merge('RGBA', (r, g, b, a))
                img.save(os.path.join(root_dir, "h", file_name[:-4]+"_h"+str(i)+".png"))

def process_features(root_dir="."):
    items = {
        "nose": "face",
        "mouth": "face",
        "eyes": "face",
        "chin": "base",
        "head": "base",
        "moustache": "facialhair",
    }
    for item in items:
        mask_features(item, items[item], root_dir)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        process_faces("p")
        hue_cycle()
        process_faces("h")
        process_features()
        process_faces("m")
        make_8bpp()
    else:
        process_faces("p", sys.argv[1])
        hue_cycle(sys.argv[1])
        process_faces("h", sys.argv[1])
        process_features(sys.argv[1])
        process_faces("m", sys.argv[1])
        make_8bpp(sys.argv[1])

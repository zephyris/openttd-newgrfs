# Anime Faces: Manager faces in an anime style
## Image generation
Graphics are derived, with heavy processing, from a fairly complex ComfyUI Stable Diffusion node network.
To re-generate all graphics, load `ottd_mgr.json`, find and install all dependencies, then queue image generation.

The idea behind the image generation is generation of a base (no hair) face, which is used to generate a depth map.
This depth map is used for a depth controlnet, and the latent image from the first generation is used as the start point, for subsequent image generation using the same seed.
The prompts for the later generations have changed features - addition of hair, different expressions, clothese, etc.

This, with careful tweaking, generates the base images, which go in the root directory. These files are named `*_00001_.png`.
These files are the Stable Diffusion output. 

Manually processed images - masking out features, nudging positions/alignments for better overlay, adding shadows etc. are in `p/`, with source `.xcf` files.

Automatically masked features are generated using the `*_mask.png` images in the root directory, using the appropriate mask to mask out features (eyes, nose, mouth, etc.) from base images, generating `.png` files in `m/`.
At this stage, the images are normalised based on skin tone and pixels in blue eyes are found and put into `_palmask.png` images.
Some hue shifting is also used, generating `.png` files in `h/`.

The actual sprites are cropped from the images in `p/`, `m/` and `h/`. They're resized to 1x, 2x and 4x zoom, using a scale-dependent minimum filter on RGB values (to enhace edge lines at small sizes) and a maximum filter on alpha values (to clean up edges at small sizes).
8-bit images using the OpenTTD palette are generated at this stage too, and the `_palmask.png` images are converted to 8-bit.

## Building
Run `make_all.sh`. This won't generate any new images, but will use the previously-generated images in the root directory, the mask images in the root directory and the manually processed images in `p/` to generate directories called `1/`, `2/` and `4/` containing the 1x, 2x and 4x sprites.
It automatically retains the newest version of any ComfyUI-generated images (ie. renames the largest in `*_00002_.png`, `*_00003_.png` etc to `*_00001_.png`, and just retains `*_00001_.png`).

Then it makes the NewGRF using `nmlc`.

cd graphics

#Download scripts from OpenGFX2 repo
#Commit 5e079a0 from Jan 2024
wget -q -O custom_dither.py https://raw.githubusercontent.com/zephyris/opengfx2/e5b86a25c28ac36e6be08dc949b75f8724dbf1eb/graphics/custom_dither.py
wget -q -O building_baseshapeproc.py https://raw.githubusercontent.com/zephyris/opengfx2/e5b86a25c28ac36e6be08dc949b75f8724dbf1eb/graphics/building_baseshapeproc.py
wget -q -O building_shapeproc.py https://raw.githubusercontent.com/zephyris/opengfx2/e5b86a25c28ac36e6be08dc949b75f8724dbf1eb/graphics/building_shapeproc.py
wget -q -O mask_tiles.py https://raw.githubusercontent.com/zephyris/opengfx2/e5b86a25c28ac36e6be08dc949b75f8724dbf1eb/graphics/mask_tiles.py
wget -q -O tools.py https://raw.githubusercontent.com/zephyris/opengfx2/e5b86a25c28ac36e6be08dc949b75f8724dbf1eb/graphics/tools.py

export PATH=$PATH:$(pwd)

custom_dither.py

cd detailed
cd 64
if [ ! -d pygen ]; then
  mkdir pygen
fi
cp -p *2x2*_32bpp.png pygen/
rm pygen/house2x2_warehouse_32bpp.png
rm pygen/house2x2_superstore_32bpp.png
rm pygen/house2x2_skyscraper_32bpp.png
building_shapeproc.py 1 temperate
building_baseshapeproc.py 1 temperate
building_shapeproc.py 1 temperate True
building_baseshapeproc.py 1 temperate True
custom_dither.py
mask_tiles.py pygen/house2x2_warehouse house2x2_warehouse_tilemask.png 1
mask_tiles.py pygen/house2x2_warehouse_snow house2x2_warehouse_tilemask.png 1
mask_tiles.py pygen/ground2x2_warehouse_base ground2x2_warehouse_tilemask.png 1
mask_tiles.py pygen/house2x2_superstore house2x2_superstore_tilemask.png 1
mask_tiles.py pygen/house2x2_superstore_snow house2x2_superstore_tilemask.png 1
mask_tiles.py pygen/ground2x2_superstore_base ground2x2_superstore_tilemask.png 1
mask_tiles.py pygen/house2x2_skyscraper house2x2_skyscraper_tilemask.png 1
mask_tiles.py pygen/house2x2_skyscraper_snow house2x2_skyscraper_tilemask.png 1
mask_tiles.py pygen/ground2x2_skyscraper_base ground2x2_skyscraper_tilemask.png 1
cd pygen
custom_dither.py
cd ../../..

cd detailed
cd 256
if [ ! -d pygen ]; then
  mkdir pygen
fi
cp -p *2x2*_32bpp.png pygen/
rm pygen/house2x2_warehouse_32bpp.png
rm pygen/house2x2_superstore_32bpp.png
building_shapeproc.py 4 temperate
building_baseshapeproc.py 4 temperate
building_shapeproc.py 4 temperate True
building_baseshapeproc.py 4 temperate True
custom_dither.py
mask_tiles.py pygen/house2x2_warehouse house2x2_warehouse_tilemask.png 4
mask_tiles.py pygen/house2x2_warehouse_snow house2x2_warehouse_tilemask.png 4
mask_tiles.py pygen/ground2x2_warehouse_base ground2x2_warehouse_tilemask.png 4
mask_tiles.py pygen/house2x2_superstore house2x2_superstore_tilemask.png 4
mask_tiles.py pygen/house2x2_superstore_snow house2x2_superstore_tilemask.png 4
mask_tiles.py pygen/ground2x2_superstore_base ground2x2_superstore_tilemask.png 4
mask_tiles.py pygen/house2x2_skyscraper house2x2_skyscraper_tilemask.png 4
mask_tiles.py pygen/house2x2_skyscraper_snow house2x2_skyscraper_tilemask.png 4
mask_tiles.py pygen/ground2x2_skyscraper_base ground2x2_skyscraper_tilemask.png 4
cd pygen
custom_dither.py
cd ../../..

cd ..

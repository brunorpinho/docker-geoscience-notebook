# Jupyter Notebook GeoScientific Python Stack

This combines the [Scipy Notebook](https://github.com/jupyter/docker-stacks/tree/master/scipy-notebook) with common packages that I use in geosciences.

## What it Gives You

* Everything in [Scipy Notebook](https://github.com/jupyter/docker-stacks/tree/master/scipy-notebook)
* [Shapely](https://github.com/Toblerity/Shapely),
	[Fiona](https://github.com/Toblerity/Fiona),
	[rasterio](https://github.com/mapbox/rasterio),
	[GeoPandas](https://github.com/geopandas/geopandas),
	[pyproj](https://github.com/jswhit/pyproj),
	[fatiando](https://github.com/fatiando/fatiando),
	[mplstereonet](https://github.com/joferkington/mplstereonet),
	[spectral-python](https://github.com/spectralpython/spectral),
	[PyTorch](http://pytorch.org)

### Python 2 and Python 3

The latest version of the [Scipy Notebook](https://github.com/jupyter/docker-stacks/tree/master/scipy-notebook) dropped Python 2.

While some geoscientific modules are still only available in Python 2 I'm using a previous tag of [Scipy Notebook](https://github.com/jupyter/docker-stacks/tree/master/scipy-notebook) with Python2 and Python3 environment configured.

### Usage

Pull the image:

```bash
docker pull brunorpinho/geoscience-notebook
```

Run the image:

```bash
docker run -it --rm -p 8888:8888 -v {add/a/local/folder/without/brackets}:/home/jovyan/work brunorpinho/geoscience-notebook:latest
```

### TODO

* implement [Mayavi](http://docs.enthought.com/mayavi/mayavi/) for 3D visualizations

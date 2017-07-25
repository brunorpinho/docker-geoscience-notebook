FROM jupyter/scipy-notebook

USER $NB_USER

RUN conda config --add channels conda-forge

RUN conda install --quiet --yes \
	'geos=3.5*' \
	'gdal=2.2*'

RUN pip3 install -I fiona --no-binary fiona

RUN conda install --quiet --yes \
	'shapely=1.5*' \
	'rasterio' \
	'geopandas=0.2*' \
	'pyproj=1.9*' \
	'spectral=0.18*'

RUN conda install --quiet --yes -p $CONDA_DIR/envs/python2 python=2.7 \
	'geos=3.5*' \
	'gdal=2.2*'

RUN pip2 install -I fiona --no-binary fiona

RUN conda install --quiet --yes -p $CONDA_DIR/envs/python2 python=2.7 \
	'shapely=1.5*' \
	'rasterio' \
	'geopandas=0.2*' \
	'pyproj=1.9*' \
	'spectral=0.18*' \
	'fatiando=0.5*' \
	'mayavi=4.5*'

RUN conda clean -tipsy

RUN git clone https://github.com/hpgl/hpgl.git
RUN cd hpgl/src/; pip install -e . --no-cache

RUN pip2 install git+https://github.com/j08lue/pycpt.git
RUN pip3 install git+https://github.com/j08lue/pycpt.git

RUN pip2 install git+https://github.com/joferkington/mplstereonet.git
RUN pip3 install git+https://github.com/joferkington/mplstereonet.git

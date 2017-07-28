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


RUN bash -c "source activate python2 && jupyter nbextension install --py mayavi --user"

RUN conda clean -tipsy

# Install pycpt to use CPT colormaps with matplotlib
RUN pip2 install git+https://github.com/j08lue/pycpt.git
RUN pip3 install git+https://github.com/j08lue/pycpt.git

# Install mplstereonet for stereonets plots with matplotlib
RUN pip2 install git+https://github.com/joferkington/mplstereonet.git
RUN pip3 install git+https://github.com/joferkington/mplstereonet.git

###
### Instalação do HPGL - High Performance Geostatistics Library
###

USER root

RUN apt-get update && \
	apt-get install -y \ 
		gcc \
		g++ \
		libboost-all-dev

RUN apt-get update && \
	apt-get install -y \ 
		liblapack-dev \
		libblas-dev \
		liblapacke-dev \
		libopenblas-dev


RUN cd /opt/; wget http://www.netlib.org/clapack/clapack.tgz && \
	tar -xvzf clapack.tgz && \
	cd /opt/CLAPACK*/ && \
	cd INCLUDE; cp * /usr/local/include/

RUN wget http://prdownloads.sourceforge.net/scons/scons-2.5.0.tar.gz && \
	tar -xvzf scons-2.5.0.tar.gz && \
	cd scons-2.5.0 && \
	python2 setup.py install

#RUN git clone https://github.com/hpgl/hpgl.git
#RUN cd hpgl/src/ && \
#	bash -c "source activate python2 && scons -j 1" && \
#	python2 setup.py install

#RUN rm -rf hpgl hpgl-bsd_0.9.9_amd64-py2.7.deb python-central_0.6.17_all.deb scons-2.5.0.tar.gz CLAPACK*

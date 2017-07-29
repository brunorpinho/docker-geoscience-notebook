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
		liblapacke-dev

RUN apt-get update && \
	apt-get install -y \ 
		scons

RUN wget http://ftp.us.debian.org/debian/pool/main/libf/libf2c2/libf2c2_20090411-2_amd64.deb && \
	dpkg -i libf2c2_20090411-2_amd64.deb

RUN wget http://ftp.us.debian.org/debian/pool/main/libf/libf2c2/libf2c2-dev_20090411-2_amd64.deb && \
	dpkg -i libf2c2-dev_20090411-2_amd64.deb

RUN wget http://mirrors.kernel.org/ubuntu/pool/universe/c/clapack/libcblas3_3.2.1+dfsg-1_amd64.deb  && \
	dpkg -i libcblas3_3.2.1+dfsg-1_amd64.deb

RUN wget http://mirrors.kernel.org/ubuntu/pool/universe/c/clapack/libcblas-dev_3.2.1+dfsg-1_amd64.deb && \
	dpkg -i libcblas-dev_3.2.1+dfsg-1_amd64.deb

RUN wget http://ftp.us.debian.org/debian/pool/main/c/clapack/libclapack3_3.2.1+dfsg-1_amd64.deb  && \
	dpkg -i libclapack3_3.2.1+dfsg-1_amd64.deb

RUN wget http://ftp.us.debian.org/debian/pool/main/c/clapack/libclapack-dev_3.2.1+dfsg-1_amd64.deb && \
	dpkg -i libclapack-dev_3.2.1+dfsg-1_amd64.deb

RUN wget https://mirror.kku.ac.th/ubuntu/ubuntu/pool/main/l/lapack/libtmglib3_3.7.1-1_amd64.deb && \
	dpkg -i libtmglib3_3.7.1-1_amd64.deb

RUN wget http://ftp.us.debian.org/debian/pool/main/l/lapack/libtmglib-dev_3.7.1-1_amd64.deb && \
	dpkg -i libtmglib-dev_3.7.1-1_amd64.deb

RUN git clone https://github.com/hpgl/hpgl.git


COPY SConstruct hpgl/src/
RUN cd hpgl/src/ && \
	bash -c "source activate python2 && scons -j 4"

RUN cd hpgl/src/ && \
	bash -c "source activate python2 && python2 setup.py install"

RUN rm -rf hpgl \
	scons-2.5.0* \
	libf2c2_20090411-2_amd64.deb \
	libf2c2-dev_20090411-2_amd64.deb \
	libtmglib3_3.7.1-1_amd64.deb \
	libtmglib-dev_3.7.1-1_amd64.deb \
	libcblas3_3.2.1+dfsg-1_amd64.deb \
	libcblas-dev_3.2.1+dfsg-1_amd64.deb \
	libclapack3_3.2.1+dfsg-1_amd64.deb \
	libclapack-dev_3.2.1+dfsg-1_amd64.deb

USER $NB_USER

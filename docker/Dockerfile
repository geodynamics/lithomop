FROM ubuntu:jammy

RUN apt-get update && \
  DEBIAN_FRONTEND='noninteractive' \
  DEBCONF_NONINTERACTIVE_SEEN='true' \
  apt-get install --yes \
    gfortran \
    build-essential \
    git \
    curl \
    libblas-dev \
    liblapack-dev \
    autoconf \
    automake \
    autoconf-archive \
    libpython2.7-dev \
    libpython2.7 \
    python2.7 \
    libtool \
    libc6-dev \
    mpich \
    sudo \
    nano

RUN useradd \
  --create-home \
  lithomop_user && echo "lithomop_user:password" | chpasswd


RUN sudo adduser lithomop_user sudo

# Need to create this link so that pythia will compile
RUN ln -s /usr/bin/python2.7 /usr/bin/python;

WORKDIR /home/lithomop_user

USER lithomop_user

#apt will install pip3, so need to do this to install pip 2.7
RUN curl -L -O "https://bootstrap.pypa.io/pip/2.7/get-pip.py"; echo "password" | sudo -S python2.7 get-pip.py; pip install setuptools; pip install ez_setup;


ENV PETSC_DIR="/home/lithomop_user/petsc-2.3.3-p16"
ENV PETSC_ARCH="/home/lithomop_user/petsc-2.3.3-p16/lib/linux-gnu-c-debug"
ENV PATH="/home/lithomop_user/petsc-2.3.3-p16/externalpackages/mpich2-1.0.5p4/bin:${PATH}"

RUN curl -L -O "https://web.cels.anl.gov/projects/petsc/download/release-snapshots/petsc-2.3.3.tar.gz"; tar -xvf petsc-2.3.3.tar.gz; cd petsc-2.3.3-p16; mkdir externalpackages; cd externalpackages; curl -L -O "https://www.mpich.org/static/downloads/1.0.5p4/mpich2-1.0.5p4.tar.gz"; tar -xvf mpich2-1.0.5p4.tar.gz; cd mpich2-1.0.5p4; ./configure; echo "password" | sudo -S make all; echo "password" | sudo -S make install; 
RUN cd petsc-2.3.3-p16; ./config/configure.py PETSC_ARCH=linux-gnu-c-debug --with_mpi=1; make all PETSC_ARCH=linux-gnu-c-debug; make install PETSC_ARCH=linux-gnu-c-debug;

RUN curl -L -O "https://github.com/geodynamics/pythia/releases/download/v0.8.1.16/pythia-0.8.1.16.tar.gz"; tar -xvf pythia-0.8.1.16.tar.gz; cd pythia-0.8.1.16; curl -L -O "https://pypi.python.org/packages/2.7/s/setuptools/setuptools-0.6c11-py2.7.egg"; echo "password" | sudo -S python setup.py build; echo "password" | sudo -S python setup.py build install;

#ENV PYTHONPATH=/usr/bin/python

RUN git clone --recurse-submodules 'https://github.com/jarettbakerdunn/lithomop.git'; cd lithomop; git checkout devel; git fetch; git pull; curl -L -O "https://pypi.python.org/packages/2.7/s/setuptools/setuptools-0.6c11-py2.7.egg"; mkdir aux-config; autoreconf -i;

RUN cd lithomop; git checkout devel; git fetch; git pull; mv docker/ez_setup.py /home/lithomop_user/.local/lib/python2.7/site-packages/; rm /home/lithomop_user/lithomop/m4/cit_python.m4; mv docker/cit_python.m4 /home/lithomop_user/lithomop/m4/;

RUN cd lithomop; autoupdate; automake --add-missing; autoreconf;
WORKDIR /home/lithomop_user/lithomop
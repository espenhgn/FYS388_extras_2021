FROM buildpack-deps:focal

RUN apt-get update && \
    apt-get install -y \
    cython3 \
    python3-dev \
    python3-pip \
    python3-numpy \
    python3-scipy \
    python3-matplotlib \
    python3-pandas \
    python3-h5py \
    python3-mpi4py \
    ipython3 \
    jupyter \
    libx11-dev \
    git \
    cmake \
    bison \
    flex \
    automake \
    libtool \
    libxext-dev \
    libxcomposite-dev \
    libncurses-dev \
    xfonts-100dpi \
    libopenmpi-dev \
    make \
    zlib1g-dev

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10 && \
    update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10 && \
    update-alternatives --install /usr/bin/ipython ipython /usr/bin/ipython3 10

RUN cd /opt
RUN git clone --depth=1 --branch 8.0.0 https://github.com/neuronsimulator/nrn

RUN cd nrn && \
    mkdir build && \
    cd build

RUN cmake -DCMAKE_INSTALL_PREFIX=/usr/local/ \
  -DCURSES_NEED_NCURSES=ON \
  -DNRN_ENABLE_INTERVIEWS=OFF \
  -DNRN_ENABLE_RX3D=ON \
  -DNRN_ENABLE_MPI=ON \
  ../nrn

RUN make
RUN make install
RUN cd src/nrnpython && \
    python setup.py install

RUN cd

RUN rm -rf nrn

# --- Install LFPy ----
RUN git clone --depth=1 --branch v2.2.2 https://github.com/LFPy/LFPy
RUN cd LFPy && \
    pip install .

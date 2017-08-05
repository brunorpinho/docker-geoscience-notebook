from os import path

cl_defines = []
for key, value in ARGLIST:
	if key == 'define':
		cl_defines.append(value)

python_ver = "2.6"

env = Environment(
	CPPDEFINES = cl_defines,
	CPPPATH = [ 
#		'/opt/boost_1_38_src/',
		'tnt_126',
		'geo_bsd/hpgl',
        'CLAPACK-3.1.1.1/INCLUDE' ],
	LIBS = ['stdc++', 'libgomp', 'pthread', 'lapack', 'tmglib', 'blas', File('/usr/lib/libf2c.a')],
	LIBPATH =  ['CLAPACK-3.1.1.1'],	
	)

dbg_suffixes = {True: '_d', False: ''}
py_pkg_suffixes = {True: '-dbg', False: ''}
ccflags = {True: '-ggdb -fPIC', 
	   False: '-ggdb -fPIC -O2 -finline-functions -fmove-loop-invariants -fopenmp -funroll-loops -march=native -msse -msse2 -mfpmath=sse -Wall -Wno-missing-braces -Wno-sign-compare '}

cppdefines = {True: ['DEBUG'],
	      False: ['NDEBUG']}

dir1 = {True: 'debug', False:'release'}

for debug in [False, True]:
	env2 = env.Clone(
		DBG_SUFFIX = dbg_suffixes[debug],
		CONFIG_NAME = dir1[debug],
		CCFLAGS = ccflags[debug],
		TEMPDIR1 = 'temp/${CONFIG_NAME}',
		PY_PKG_DIR = 'out/$CONFIG_NAME',
		SHLIBPREFIX = '')

	env2.Append(CPPDEFINES = cppdefines[debug])
	env2['BUILDROOT'] = '$TEMPDIR1'
	env2.VariantDir('$BUILDROOT/geo_bsd', 'geo_bsd', duplicate=0)
	hpgl_src = env2.Glob('$BUILDROOT/geo_bsd/hpgl/*.cpp') 
	env2.SharedLibrary('geo_bsd/hpgl${DBG_SUFFIX}', hpgl_src)
	env2.SharedLibrary('geo_bsd/_cvariogram${DBG_SUFFIX}', 
			env2.Glob('$BUILDROOT/geo_bsd/_cvariogram/*.cpp'))


Default(['geo_bsd'])

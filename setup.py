
from setuptools import setup, find_packages


setup(
    name='pytools',
    version='1.0',
    author_email='liuyug@gmail.com',
    url='',
    license='MIT',
    description='python tools',
    python_requires='>=3',
    platforms=['noarch'],
    packages=find_packages(),
    entry_points={
        'console_scripts': [
            'ascii = pytools.ascii:run',
            'httpd = pytools.httpd:run',
            'icons = pytools.icons:run',
        ],
    },
    zip_safe=False,
)

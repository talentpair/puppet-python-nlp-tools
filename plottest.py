import os

from matplotlib import get_backend
from matplotlib import use as set_backend

os.environ['QT_API'] = 'pyside'
DEFAULT_MPL_BACKEND = get_backend()

try:
    import PyQt4  # noqa
    set_backend('Qt4Agg')
    from matplotlib import pyplot as plt
except ImportError:
    try:
        set_backend(DEFAULT_MPL_BACKEND)
        from matplotlib import pyplot as plt
    except ImportError:
        set_backend('TkAgg')
        from matplotlib import pyplot as plt

if __name__ == '__main__':
    plt.plot([1, 2, 3])
    plt.show()

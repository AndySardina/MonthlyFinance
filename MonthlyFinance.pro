TEMPLATE = subdirs

CONFIG += ordered

SUBDIRS += \
  QtQmlModels \
  QtSuperMacros \
  entitymanagement \
  monthlyfinance \
#  test


QtQmlModels.subdir = 3dparty/QtQmlModels
QtSuperMacros.subdir = 3dparty/QtSuperMacros

entitymanagement.depends = QtSuperMacros
monthlyfinance.depends = entitymanagement QtQmlModels
#test.depends = QtSuperMacros entitymanagement

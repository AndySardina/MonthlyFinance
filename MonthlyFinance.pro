TEMPLATE = subdirs

CONFIG += ordered

SUBDIRS += \
  entitymanagement \
  monthlyfinance \
#  test

monthlyfinance.depends = entitymanagement

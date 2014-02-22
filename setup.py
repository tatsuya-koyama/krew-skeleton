#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
  setup.py
"""

import sys
import commands
from optparse import OptionParser

sys.path.append('python-util')
from tkutil.console import cprint
from tkutil.config import Config

#-------------------------------------------------------------------------------
# constants
#-------------------------------------------------------------------------------

CONFIG_PATH = 'setup.cfg'

#-------------------------------------------------------------------------------
# main routine
#-------------------------------------------------------------------------------

def main(args, opts):
    print('arguments: %s' % args)
    print('options  : %s' % opts)
    print ''

    #--- check output path
    if not opts.output_path:
        cprint('<red:[USAGE] ./setup.py -o path/to/skeleton />\n')
        return 1

    outpath = opts.output_path
    if not (outpath.endswith('/')):
        outpath += '/'

    (status, stdout) = commands.getstatusoutput('cd ' + outpath)
    if (status != 0):
        cprint('<red:[Error] output_path not found: /><yellow:%s/>\n' % outpath)
        return 1


    #--- load config file
    cprint('<yellow:load config file:/> %s' % CONFIG_PATH)
    config = Config(CONFIG_PATH)
    config.describe()


    #--- dryrun?
    if opts.dryrun:
        cprint('<red:DRY RUN MODE./>')
        return 1


    #--- execute shell commands
    print ''
    shell_cmds = get_shell_commands(outpath, config)
    for cmd in shell_cmds:
        cprint('<cyan:$ %s/>' % cmd)
        cprint('<blue:' + '-' * len(cmd) + '/>')
        (status, stdout) = commands.getstatusoutput(cmd)
        print stdout
        if (status != 0):
            cprint('<red:[Error]/>')
            return 1

    print 'completed.'
    return 0


def get_shell_commands(outpath, config):
    cd2target = 'cd %s; ' % outpath
    return [
        'cp -r TEMPLATES/* ' + outpath,
        cd2target + 'rm -rf core-src/%s' % config.names.as3_package_name,
        cd2target + 'mv -f core-src/__PACKAGE_NAME__ core-src/%s' % config.names.as3_package_name,

        replace_cmd(cd2target, './projects',          '__APP_ID__',       config.names.app_id),
        replace_cmd(cd2target, './projects',          '__APP_TITLE__',    config.names.app_title),
        replace_cmd(cd2target, './projects',          '__APP_FILENAME__', config.names.app_filename),
        replace_cmd(cd2target, './projects',          '__SWF_FILENAME__', config.names.swf_filename),
        replace_cmd(cd2target, './commandline-build', '__SWF_FILENAME__', config.names.swf_filename),
        replace_cmd(cd2target, './core-src',          '__PACKAGE_NAME__', config.names.as3_package_name),

        replace_cmd(cd2target, './projects',          '__APP_VERSION__',  config.info.app_version),
        replace_cmd(cd2target, './projects',          '__DESCRIPTION__',  config.info.description),
        replace_cmd(cd2target, './projects',          '__PUBLISHER__',    config.info.publisher),
        replace_cmd(cd2target, './projects',          '__CREATOR__',      config.info.creator),
        replace_cmd(cd2target, './projects',          '__LANGUAGE__',     config.info.language),

        replace_cmd(cd2target, './projects',          '__DEFAULT_BG_COLOR__', config.attributes.default_bg_color),
        replace_cmd(cd2target, './projects',          '__DEFAULT_FPS__',      config.attributes.default_fps),
        replace_cmd(cd2target, './projects',          '__AUTO_ORIENTS__',     config.attributes.auto_orients),
        replace_cmd(cd2target, './projects',          '__ASPECT_RATIO__',     config.attributes.aspect_ratio),

        replace_cmd(cd2target, './projects',          '__AIR_SDK_VER__',  config.env.air_sdk_ver),

        'cp .gitignore ' + outpath,
        'cp -r SAMPLE_ASSETS/* ' + outpath,
        cd2target + 'git submodule add git@github.com:tatsuya-koyama/krewFramework.git krewFramework',
    ]

def replace_cmd(cd2target='cd path/to;', target_dir='./',
                key_str='_PACKAGE_', dest_str='package'):
    return cd2target \
        + ('grep -lr %s %s ' % (key_str, target_dir)) \
        + ('| xargs sed -i "" "s/%s/%s/g"' % (key_str, dest_str))


#-------------------------------------------------------------------------------
# entry point
#-------------------------------------------------------------------------------

if __name__ == '__main__':
    opt_parser = OptionParser()

    opt_parser.add_option('-d', '--dryrun', action='store_true', default=False,
                          dest='dryrun', help='show config values without running commands.')
    opt_parser.add_option('-p', '--path', action='store', type='string',
                          dest='output_path', help='[required] skeleton files output target path.')

    opts, args = opt_parser.parse_args()
    sys.exit(main(args, opts))


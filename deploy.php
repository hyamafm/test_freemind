<?php
namespace Deployer;

require 'recipe/common.php';

set('application', 'test');
set('repository', 'git@github.com:hyamafm/test_freemind.git');

// Add shared_dirs
set('shared_dirs', []);

// shared files
set('shared_files', []);

// Add writable_dirs
set('writable_dirs', []);

/**
 * 'shared' will be called twice.
 * First call is done to do composer/bower/npm in symlinked directory.
 * (Would be much more faster in second run)
 * Second call is for symlinking the node_modules and bower_components.
 * (For first run. These dirs are created after the first run of bower/npm)
 */

task('deploy', [
    'deploy:info',
    'deploy:prepare',
    'deploy:lock',
    'deploy:release',
    'deploy:update_code',
    'deploy:shared',
    'deploy:writable',
    'deploy:vendors',
    'deploy:clear_paths',
    'deploy:symlink',
    'deploy:cleanup'
    'deploy:unlock',
]);

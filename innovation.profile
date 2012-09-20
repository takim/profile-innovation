<?php

/**
 * Implements hook_install_tasks().
 */
function innovation_install_tasks(&$install_state) {
  // Determine whether translation import tasks will need to be performed.
  return array(
    'innovation_finish' => array(
      'display_name' => st('Apply configuration'),
      'display' => TRUE,
      'type' => 'batch',
    ),
  );
}

/**
 * Do things that needs to be done after all modules have been enabled.
 */
function innovation_finish() {
  module_list(TRUE);
  drupal_flush_all_caches();
  // Rebuild default components.
  if (module_exists('defaultconfig')) {
    drupal_flush_all_caches();
    module_list(TRUE);
    return defaultconfig_rebuild_batch_defintion(
      st('Apply configuration'),
      st('The installation encountered an error')
    );
  }
  return array();
}

/**
 * Implements of hook_ctools_plugin_directory().
 */
function innovation_ctools_plugin_directory($module, $plugin) {
  if ($module == 'ctools' || $module == 'panels') {
    return 'plugins/' . $plugin;
  }
}

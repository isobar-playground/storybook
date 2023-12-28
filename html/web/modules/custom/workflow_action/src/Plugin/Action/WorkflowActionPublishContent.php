<?php

namespace Drupal\workflow_action\Plugin\Action;

use Drupal\Core\Action\ActionBase;
use Drupal\Core\Session\AccountInterface;

/**
 * Provides an action to publish Node to the Production environment.
 *
 * @Action(
 *   id = "workflow_action_publish_content",
 *   label = @Translation("AAAAPublish content from the Staging to the Production environment"),
 *   type = "node"
 * )
 */
class WorkflowActionPublishContent extends ActionBase {

  /**
   * {@inheritdoc}
   */
  public function execute($entity = NULL) {
    if ($entity->hasField('moderation_state') && $entity->moderation_state->value == 'draft') {
      $entity->set('moderation_state', 'published');
      $entity->save();
    }
  }

  /**
   * {@inheritdoc}
   */
  public function access($object, AccountInterface $account = NULL, $return_as_object = FALSE) {
    return $object->hasField('moderation_state') && $object->moderation_state->value == 'draft';
  }

}

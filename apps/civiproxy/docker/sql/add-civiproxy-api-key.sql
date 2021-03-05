UPDATE civicrm.civicrm_contact
INNER JOIN
    civicrm.civicrm_uf_match drupal_user_field ON (drupal_user_field.contact_id = civicrm_contact.id)
SET
    civicrm_contact.api_key = 'docker-api-key'
WHERE
    drupal_user_field.uf_name = 'admin@example.com'
# main funnel table
SELECT
    MIN(event_timestamp) event_timestamp,
    event_name,
    user_pseudo_id,
    country
  FROM
    `tc-da-1.turing_data_analytics.raw_events`
    
  WHERE
  event_name IN (
    'first_visit',
    'view_item',
    "add_to_cart",
    'purchase'
  )
  AND country in (
    "United States",
    "India",
    "Canada"
  )
  group by 2,3,4
ORDER BY
  user_pseudo_id


# funnel data by browser
WITH
  filtered_raw_events AS (
  SELECT
    MIN(event_timestamp) event_timestamp,
    event_name,
    user_pseudo_id
  FROM
    `tc-da-1.turing_data_analytics.raw_events`
  GROUP BY
    2,
    3 )

SELECT
  original_raw_events.event_date,
  original_raw_events.event_timestamp,
  original_raw_events.event_name,
  original_raw_events.user_pseudo_id,
  original_raw_events.browser
FROM
  `turing_data_analytics.raw_events` original_raw_events
JOIN
  filtered_raw_events
ON
  original_raw_events.event_timestamp = filtered_raw_events.event_timestamp
  AND original_raw_events.user_pseudo_id = filtered_raw_events.user_pseudo_id
  AND original_raw_events.event_name = filtered_raw_events.event_name
WHERE
  original_raw_events.event_name IN (
    'first_visit',
    'view_item',
    "add_to_cart",
    'purchase'
  )
  AND browser in (
    "Chrome",
    "Safari")
ORDER BY
  user_pseudo_id
create function generate_latest_coverage_json()
  returns json as $$
declare latest_release varchar;
begin
select release into latest_release from audit_event order by release::semver limit 1;
return(
  select row_to_json(c) from (
    select release, release_date, spec,
           (select source from (select source from audit_event where release = latest_release limit 1) s) as source,
           (select array_agg(row_to_json(endpoint_coverage)) from endpoint_coverage where release = latest_release) as endpoints,
           (select array_agg(row_to_json(audit_event_test)) from audit_event_test where release = latest_release) as tests
      from open_api
     where release = latest_release
     group by release, release_date, spec) c);
end;
$$ language plpgsql;
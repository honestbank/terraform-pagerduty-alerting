output "level_one_schedule_id" {
  value = module.schedule.level_one_schedule_id
}

output "level_two_schedule_id" {
  value = module.schedule.level_two_schedule_id
}

output "dummy_user_ids" {
  description = "The dummy users created to be placed into rotation."
  value       = module.dummy_users.*.id
}

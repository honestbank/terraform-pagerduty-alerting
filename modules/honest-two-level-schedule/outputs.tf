output "level_one_schedule_id" {
  description = "The `id` attribute of the Level 1 schedule."
  value       = module.level_one_schedule.id
}

output "level_two_schedule_id" {
  description = "The `id` attribute of the Level 2 schedule."
  value       = module.level_two_schedule.id
}

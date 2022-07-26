output "schedule_id" {
  description = "The `id` attribute of the schedule."
  value       = module.schedule.id
}

output "user_one_id" {
  description = "Dummy user created for inserting into the schedule."
  value       = module.user_one.id
}

output "user_two_id" {
  description = "Dummy user created for inserting into the schedule."
  value       = module.user_two.id
}

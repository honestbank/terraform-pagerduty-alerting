variable "description" {
  description = "Team description."
  type        = string
}

variable "name" {
  description = "Team name."
  type        = string
}

variable "team_members" {
  description = "Members to add to the team. Keys are 'name' while values are 'role' in the team"
  type        = map(string)
}

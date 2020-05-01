
resource "aws_resourcegroups_group" "resourcegroups_group" {
  name = "${var.environment}-group"

  resource_query {
    query = <<-JSON
{
  "ResourceTypeFilters": [
    "AWS::AllSupported"
  ],
  "TagFilters": [
    {
      "Key": "Environment",
      "Values": ["${var.environment}"]
    }
  ]
}
  JSON
  }
}

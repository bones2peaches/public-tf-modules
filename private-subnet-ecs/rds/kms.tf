data "aws_iam_policy_document" "kms" {

  statement {
    principals {
     type = "AWS"
     identifiers =["arn:aws:iam::${var.aws_account_id}:root"] 
      }
    condition {
      test = "Bool"
      values = [true]
      variable = ["kms:GrantIsForAWSResource"]
    }      
    
    actions   = [ "kms:Create*",
                "kms:Describe*",
                "kms:Enable*",
                "kms:List*",
                "kms:Put*",
                "kms:Update*",
                "kms:Revoke*",
                "kms:Disable*",
                "kms:Get*",
                "kms:Delete*",
                "kms:TagResource",
                "kms:UntagResource",
                "kms:ScheduleKeyDeletion",
                "kms:CancelKeyDeletion"]
    resources = ["*"]
    effect = "Allow"

  }

  statement {
    principals {
     type = "AWS"
     identifiers =var.iam_roles
      }
    actions   = ["kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:CreateGrant",
                "kms:ListGrants",
                "kms:DescribeKey"]
    resources = ["*"]
    effect = "Allow"
  }
}



resource "aws_kms_key" "this" {
  policy = aws_iam_policy_document.kms.json
}
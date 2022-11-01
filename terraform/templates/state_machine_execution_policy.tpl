{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": 
        "states:StartExecution",
      "Effect": 
        "Allow",
      "Resource": [          
        "arn:aws:states:${region}:${account}:stateMachine:${state_machine}"
      ]
    }
  ]
}
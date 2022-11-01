from diagrams import Diagram, Cluster
from urllib.request import urlretrieve
from diagrams.custom import Custom
from diagrams.aws.integration import Eventbridge
from diagrams.aws.integration import StepFunctions
from diagrams.aws.storage import SimpleStorageServiceS3Bucket



with Diagram("State Machine", show=False):
    step_functions = StepFunctions("Step Functions State Machine")
    event_bridge = Eventbridge("Event Bridge")
    s3_notification = SimpleStorageServiceS3Bucket("S3 Notification")
    
    event_bridge >> step_functions
    s3_notification >> step_functions
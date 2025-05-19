
# Implementation Explanation

## 1. Kubernetes Objects Choice

I chose to use the following Kubernetes objects for my implementation:

### StatefulSet for Database
I implemented a StatefulSet for the database component because:
- It provides stable, unique network identifiers for each pod
- It offers stable, persistent storage with volume mounting
- It ensures ordered, graceful deployment and scaling
- It guarantees ordered, graceful deletion and termination

Unlike regular Deployments, StatefulSets maintain a sticky identity for each pod. This is critical for the database tier as it needs stable network identities and persistent storage. The StatefulSet ensures that when pods are rescheduled, they maintain their identity and reconnect to the same persistent volumes.

### Deployment for Frontend/Backend
For the frontend and backend components, I used Deployments because:
- They're stateless applications that don't require stable network identities
- They can be scaled up/down without concern for pod identity
- They benefit from the rolling update strategy provided by Deployments

### ConfigMaps and Secrets
I used ConfigMaps to store non-sensitive configuration data and Secrets for sensitive information like database credentials. This separation of configuration from code follows best practices and makes the application more portable.

## 2. Method Used to Expose Pods to Internet Traffic

I used a combination of Service types to expose the application:

### ClusterIP Service for Database
The database is exposed only internally using a ClusterIP service, which:
- Prevents direct external access to the database
- Allows other components within the cluster to communicate with the database
- Enhances security by limiting the attack surface

### LoadBalancer Service for Frontend
I exposed the frontend using a LoadBalancer service, which:
- Automatically provisions an external load balancer in GKE
- Provides a public IP address for external access
- Distributes traffic across frontend pods for high availability

This multi-tiered approach to exposure ensures that only the components that need to be publicly accessible are exposed, following the principle of least privilege.

## 3. Persistent Storage Implementation

I implemented persistent storage using:

### Persistent Volume Claims (PVCs)
Each database pod in the StatefulSet has its own PVC that:
- Survives pod restarts and rescheduling
- Maintains data integrity across deployments
- Ensures no data loss when pods are deleted and recreated

### Storage Class
I used the standard GKE storage class which:
- Automatically provisions persistent disks in Google Cloud
- Provides durable storage for the database
- Handles the underlying storage provisioning automatically

This implementation ensures that when database pods are deleted, the data remains intact. When new pods are created, they reconnect to the same persistent volumes, maintaining data consistency.

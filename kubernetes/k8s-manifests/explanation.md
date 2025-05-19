#   Kubernetes Implementation Explanation

##  1. Choice of Kubernetes Objects

### StatefulSet for MongoDB

I chose to implement MongoDB using a StatefulSet rather than a Deployment for several key reasons:

1.  **Stable Network Identity**: MongoDB requires a stable hostname that doesn't change when pods are rescheduled. StatefulSets provide predictable pod names (mongodb-0, mongodb-1, etc.) that remain consistent across pod rescheduling.
2.  **Ordered Deployment**: StatefulSets guarantee ordered deployment and scaling, which is critical for database replication and clustering scenarios. Even though I'm currently using a single replica, this architecture allows for future scaling with proper primary/secondary relationships.
3.  **Persistent Volume Per Pod**: Each pod in a StatefulSet gets its own PersistentVolumeClaim that stays with the pod throughout its lifecycle. This ensures data persistence even if pods are rescheduled to different nodes.

### Deployments for Frontend and Backend

For the frontend and backend services, I used standard Deployments because:

1.  **Horizontal Scaling**: Deployments allow easy horizontal scaling of stateless services.
2.  **Rolling Updates**: They provide zero-downtime updates with configurable rolling update strategies.
3.  **Self-Healing**: Deployments automatically replace failed pods, maintaining desired replica count.

##  2. Method Used to Expose Pods to Internet Traffic

I used a layered approach for exposing services:

1.  **Frontend Service (LoadBalancer)**: The frontend service is exposed using a LoadBalancer type of Service, which provides an external IP address accessible from the internet. This is the entry point for all user traffic.
2.  **Backend Service (ClusterIP)**: The backend service is exposed only within the cluster using a ClusterIP type of Service. This ensures that the API is not directly accessible from outside the cluster, enhancing security.
3.  **MongoDB Service (Headless)**: For MongoDB, I used a Headless Service (clusterIP=None). This provides stable network identities for MongoDB pods, which is essential for replication and clustering.

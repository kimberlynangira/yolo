# Implementation Explanation

## 1. Choice of Kubernetes Objects

### Deployment for MongoDB
I chose to implement a Deployment for the MongoDB database along with appropriate services:
- **MongoDB Deployment**: Manages the lifecycle of MongoDB pods and ensures they're always running
- **MongoDB Services**: I created two services (`mongodb` and `mongodb-service`) as headless services (ClusterIP: None) to provide stable DNS names for database access

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mongodb-deployment
  namespace: yolo-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mongodb
  template:
    metadata:
      labels:
        app: mongodb
    spec:
      containers:
      - name: mongodb
        image: mongo:latest
        ports:
        - containerPort: 27017
        volumeMounts:
        - name: mongodb-data
          mountPath: /data/db
      volumes:
      - name: mongodb-data
        persistentVolumeClaim:
          claimName: mongodb-pvc
```

### Deployments for Frontend and Backend Applications
For the frontend and backend applications, I used Deployments because:
- They're stateless and don't require stable network identities
- They benefit from the easy scaling and rolling updates that Deployments provide
- The separation of frontend and backend improves application architecture and scaling capabilities

## 2. Method Used to Expose Pods to Internet Traffic

I used multiple service types to expose different parts of my application appropriately:

### LoadBalancer Service for Frontend
```yaml
apiVersion: v1
kind: Service
metadata:
  name: frontend-service
  namespace: yolo-app
spec:
  selector:
    app: frontend
  ports:
  - port: 80
    targetPort: 3000
  type: LoadBalancer
```
This service is of type LoadBalancer (with external IP 34.55.124.145), which provisions an external IP address in GKE. This exposes the frontend application to the internet, allowing users to access the shopping cart functionality.

### ClusterIP Service for Backend
```yaml
apiVersion: v1
kind: Service
metadata:
  name: backend-service
  namespace: yolo-app
spec:
  selector:
    app: backend
  ports:
  - port: 5000
    targetPort: 5000
  type: ClusterIP
```
The backend service uses ClusterIP to make it accessible only within the cluster. This adds a layer of security by preventing direct external access to the API.

### Headless Services for MongoDB
```yaml
apiVersion: v1
kind: Service
metadata:
  name: mongodb-service
  namespace: yolo-app
spec:
  selector:
    app: mongodb
  ports:
  - port: 27017
    targetPort: 27017
  clusterIP: None
```
This headless service allows direct connection to specific MongoDB pods by DNS name. This is internal to the cluster only, as the database should not be directly exposed to the internet.

The LoadBalancer type for the frontend is appropriate for production deployments on cloud providers like GKE because it:
- Automatically provisions a cloud load balancer
- Handles traffic distribution across pods
- Provides a stable external IP address
- Includes health checking and automatic pod removal for failing instances

## 3. Use of Persistent Storage

I implemented persistent storage through PersistentVolumeClaims to ensure data durability. This approach means that even if the MongoDB pod is deleted or rescheduled, the data remains intact.

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mongodb-pvc
  namespace: yolo-app
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

The MongoDB deployment references this PVC:
```yaml
volumes:
- name: mongodb-data
  persistentVolumeClaim:
    claimName: mongodb-pvc
```

This ensures:
- Database storage persists independently of pod lifecycle
- The storage is retained when pods are deleted
- The same storage is reattached when the pod is recreated
- Data is preserved across pod lifecycle events

To test this persistence:
1. Add items to the shopping cart
2. Delete the MongoDB pod: `kubectl delete pod [mongodb-pod-name] -n yolo-app`
3. Wait for the pod to automatically restart
4. Verify that all items added to the cart remain in the database

This implementation guarantees that customer shopping cart data is never lost due to pod failures or restarts, which is essential for a production e-commerce application.

## Namespace Strategy

I deployed all application components in a dedicated `yolo-app` namespace for:
- Logical isolation from other applications in the cluster
- Easier resource management and monitoring
- Simplified access control and permission management
- Better organization of related resources

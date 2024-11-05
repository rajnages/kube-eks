############Basic Kubernetes Commands############
# Get information about cluster
kubectl cluster-info
kubectl version
kubectl config view

# Context and configuration
kubectl config get-contexts                # List all contexts
kubectl config use-context <context_name>  # Switch to different context
kubectl config current-context            # Show current context


################Pod Operations################
# Pod management
kubectl get pods                          # List all pods in default namespace
kubectl get pods -n <namespace>           # List pods in specific namespace
kubectl get pods --all-namespaces        # List pods in all namespaces
kubectl get pods -o wide                  # List pods with more details
kubectl describe pod <pod_name>           # Detailed info about pod

# Pod creation and deletion
kubectl run <pod_name> --image=<image>    # Create a pod
kubectl delete pod <pod_name>             # Delete a pod
kubectl delete pods --all                 # Delete all pods

# Pod troubleshooting
kubectl logs <pod_name>                   # View pod logs
kubectl logs -f <pod_name>                # Stream pod logs
kubectl exec -it <pod_name> -- /bin/bash  # Get shell access to pod
kubectl port-forward <pod_name> 8080:80   # Port forwarding

##############Deployment Operations################
# Deployment management
kubectl get deployments                   # List deployments
kubectl describe deployment <name>        # Show deployment details
kubectl scale deployment <name> --replicas=3  # Scale deployment

# Deployment updates
kubectl set image deployment/<name> container=new_image  # Update image
kubectl rollout status deployment/<name>  # Check rollout status
kubectl rollout history deployment/<name> # View rollout history
kubectl rollout undo deployment/<name>    # Rollback deployment

###################Service Operations###################
# Service management
kubectl get services                      # List all services
kubectl describe service <name>           # Show service details
kubectl expose deployment <name> --port=80 --type=LoadBalancer  # Create service

##################Namespace Operations##################
# Namespace management
kubectl get namespaces                    # List namespaces
kubectl create namespace <name>           # Create namespace
kubectl delete namespace <name>           # Delete namespace

################Troubleshooting Commands################
# Cluster troubleshooting
kubectl get events                        # Show cluster events
kubectl get events --sort-by=.metadata.creationTimestamp  # Sorted events

# Resource troubleshooting
kubectl describe node <node_name>         # Node details
kubectl top nodes                        # Show node resource usage
kubectl top pods                         # Show pod resource usage

# Debug with temporary pod
kubectl run tmp-shell --rm -i --tty --image nicolaka/netshoot -- /bin/bash

# Check API resources
kubectl api-resources                     # List all resources
kubectl explain <resource>                # Get documentation

###############Configuration and Security################
# ConfigMaps and Secrets
kubectl get configmaps                    # List ConfigMaps
kubectl get secrets                       # List Secrets
kubectl create configmap <name> --from-file=<path>  # Create ConfigMap
kubectl create secret generic <name> --from-literal=key=value  # Create Secret

# RBAC
kubectl get roles                         # List roles
kubectl get rolebindings                 # List role bindings
kubectl auth can-i <verb> <resource>     # Check permissions


####################Advanced Commands####################
# JSON/YAML output
kubectl get pod <pod> -o yaml            # Get pod definition in YAML
kubectl get pod <pod> -o json            # Get pod definition in JSON

# Label operations
kubectl label pods <pod> key=value       # Add/update label
kubectl label pods <pod> key-            # Remove label

# Annotations
kubectl annotate pods <pod> key=value    # Add annotation

################Common Troubleshooting Scenarios################
# Pod not starting
kubectl describe pod <pod_name>           # Check events
kubectl logs <pod_name> --previous       # Check previous container logs

# Service not accessible
kubectl get endpoints <service_name>      # Check endpoints
kubectl get events | grep <service_name>  # Check service events

# Node issues
kubectl drain <node_name>                # Safely evict pods
kubectl cordon <node_name>               # Mark node as unschedulable
kubectl uncordon <node_name>             # Mark node as schedulable

########################Resource Monitoring and Debugging########################
# Advanced Pod Debugging
kubectl debug <pod-name> -it --image=ubuntu    # Create a debug container
kubectl attach <pod-name> -c <container>       # Attach to a running container
kubectl cp <pod-name>:/path/file ./local/path  # Copy files from/to pod
kubectl top pod <pod-name> --containers        # Show container-level metrics

#######Advanced Deployment Operations#####
# Canary Deployments
kubectl set image deployment/<name> <container>=<image>:<tag> --record    # Record deployment changes
kubectl patch deployment <name> -p '{"spec": {"progressDeadlineSeconds": 300}}'  # Set rollout deadline

# Advanced Scaling
kubectl autoscale deployment <name> --min=2 --max=5 --cpu-percent=80     # HPA setup
kubectl scale statefulset/<name> --replicas=5                            # Scale StatefulSet
kubectl rollout pause deployment/<name>                                   # Pause rollout
kubectl rollout resume deployment/<name>   

##################Network Diagnostics##################
# Service and Network Debugging
kubectl run curl --image=curlimages/curl -i --tty --rm -- sh    # Test network connectivity
kubectl run netshoot --rm -it --image nicolaka/netshoot -- /bin/bash    # Network debugging
kubectl port-forward svc/<service> 8080:80                      # Forward service port
kubectl proxy --port=8080                                       # Start proxy to API server

# DNS Debugging
kubectl run dnsutils --image=gcr.io/kubernetes-e2e-test-images/dnsutils --rm -it -- bash
nslookup kubernetes.default.svc.cluster.local                   # Test DNS resolution
                               # Resume rollout
#############Advanced Troubleshooting#############
# Performance Analysis
kubectl top pods --containers=true                            # Container resource usage
kubectl get pods -o custom-columns=NAME:metadata.name,STATUS:status.phase,NODE:spec.nodeName
kubectl get events --sort-by=.metadata.creationTimestamp      # Sorted cluster events

# Advanced Debugging
kubectl alpha debug pod/<pod> --copy-to=<debug-pod> --container=<container>  # Debug with copy
kubectl get pods -o jsonpath='{.items[*].spec.containers[*].image}'  # List all container images
kubectl get pods -o json | jq '.items[] | select(.metadata.namespace=="default")'  # JSON filtering
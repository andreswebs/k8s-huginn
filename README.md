# k8s-huginn

A set of configuration templates for installing [Huginn](https://github.com/huginn/huginn) on Kubernetes.

This is a poor-man's templating example using `bash` and `envsubst` to solve the problem of declarative configuration of a common off-the-shelf application (in this case Huginn) on Kubernetes. See [install.sh](install.sh)

The _locus classicus_ of the discussion is the background whitepaper by Brian Grant:

Grant, Brian. 2017. ["Declarative application management in Kubernetes"](https://github.com/kubernetes/community/blob/master/contributors/design-proposals/architecture/declarative-application-management.md) (accessed on 2021-04-28)


## Prerequisites

You need a working k8s cluster and `kubectl` configured.

The DB template uses a storage class named `gp2` in the Kubernetes environment. That's the default storage class in AWS EKS, but can be changed to any other storage class as desired.

You also need `bash`, `envsubst` and `pwgen` installed.


## Install on Kubernetes

```sh
./install.sh
```

## Uninstall

```sh
kubectl delete namespace huginn
```

## Authors

**Andre Silva** [@andreswebs](https://github.com/andreswebs)


## License

This project is licensed under the [Unlicense](UNLICENSE.md).


## Acknowledgements

The k8s manifests here are based on those presented by Nick True in his blog series about configuring Huginn (listed on the references below). See his repo:

<https://github.com/nick-true-dev/usable-k8s-projects>


## References

<https://github.com/huginn/huginn/blob/master/doc/docker/install.md>

<https://hub.docker.com/r/huginn/huginn>

<https://hub.docker.com/r/huginn/huginn-single-process>

<https://blog.true-kubernetes.com/automatically-search-craigslist-using-huginn-and-kubernetes/>

<https://blog.true-kubernetes.com/automatically-search-craigslist-using-huginn-and-kubernetes-part-2/>

<https://gideonwolfe.com/posts/sysadmin/huginn/intro/>

<https://gideonwolfe.com/posts/sysadmin/huginn/setup/>

<https://gideonwolfe.com/posts/sysadmin/huginn/status/>

<https://gideonwolfe.com/posts/sysadmin/huginn/disasters/>

# jx
>  commands https://jenkins-x.io/developing/kube-context/

## Projects
* import a project
    ```
    $ jx import --url https://github.com/jenkins-x/spring-boot-web-example.git --branches "develop|PR-.*|feature.*"
    ```

## Environments
* show environments
    ```
    $ jx get env
    $ jx get environments
    ```
* switch environment
    ```
    $ jx environment
    ```
* edit environment
    ```
    $ jx edit env -b --name prod --label Production --no-gitops --namespace my-prod
    ```        

### Applications
*  upgrade apps
    ```
    $ jx upgrade apps
    ```

* upgrade a particular app
    ```
    $ jx upgrade app my-app
    ```

### Cluster
* switch cluster
    ```
    $ jx context
    ```
* kubernetes [Cheat Sheets](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

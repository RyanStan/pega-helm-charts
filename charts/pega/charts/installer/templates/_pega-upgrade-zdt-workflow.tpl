{{- define  "pega.upgrade.zdt.workflow" -}}
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
    generateName: cool-job
    labels:
    workflows.argoproj.io/archive-strategy: "false"
    annotations:
        name: {{ .name }}
        namespace: {{ .root.Release.Namespace }}
        workflows.argoproj.io/description: |
            This is a simple hello world example.
            You can also run it in Python: https://couler-proj.github.io/couler/examples/#hello-world
spec:
    entrypoint: upgrade-zdt-steps
    templates:
    - name: upgrade-zdt-steps
        steps:
        - - name: preupgrade
            template: preupgrade
        - - name: upgrade
            template: upgrade
    - name: preupgrade
        container:
            {{ template "pega.install.container" dict "root" $ "action" "pre-upgrade" "name" (include "pegaPreDBUpgrade" .) }} # TODO: make sure values are correctly getting passed in
    - name: upgrade
        container:
            {{ template "pega.install.container" dict "root" $ "action" "upgrade" "name" (include "pegaDBZDTUpgrade" .) }} # TODO: make sure values are correctly getting passed in
---
{{- end -}}


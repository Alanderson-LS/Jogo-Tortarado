# Como dar o build do web e dar o deploy

1.
No Godot, abra:
Projeto > Exportar > Web (Executável)
(baixe a importação do web se necessário)

2.
Export Path: "dict/index.html"
(crie a pasta dict no repo se necessário)

3.
Garanta essas configurações:
- Suporte a Extensões: []
- Suporte a Threads: []
- Para Desktop: [x]
- Para Mobile: [x]
- Ícone exportado: [x]
- Documento HTML personalizado: ""
- Inclusão na Head: ""
- Política de Redimensionamento: Adaptive
- Focar Canvas ao Iniciar: [x]
- Teclado virtual experimental: []
- Habilitado: []
- Garantir Headers: [x]
- Página Offline: ""
- Exibição: Standalone
- Orientação: Landscape

4.
Exportar Projeto

5.
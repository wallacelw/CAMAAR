# CAMAAR
Sistema para avaliação de atividades acadêmicas remotas do CIC

# Parte Técnica
**Dependencias para subir o projeto**
- A Versão do Ruby é a 3.2.0
- As gemas e suas respectivas versões podem ser encontradas no CAAMAR/Gemfile. Para instalar as dependencias, basta executar:

```bash
cd CAAMAR
gem install bundler
bundle install
```

**Como executar o servidor**
- Para inicializar o servidor, basta executar:

```bash
cd CAAMAR
rails s
```

**Como executar os testes**
- Para executar os testes do rspec:

```bash
cd CAAMAR
rspec --format documentation
```

- Para executar os testes do cucumber:

```bash
cd CAAMAR
bundle exec cucumber
```

**Como executar o analisador de código:**

```bash
cd CAAMAR
bundle exec rubycritic
```

E em seguida, abrir o arquivo *tmp/rubycritic/overview.html*
> Obs.: O RubyCritic faz o teste de coverage

# Participantes e informações da organização
- Podem ser encontradas [na Wiki](https://github.com/wallacelw/CAMAAR/wiki/Organiza%C3%A7%C3%A3o)

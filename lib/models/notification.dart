class NotificationModel {
  final int id;
  bool lida;
  final DateTime dataCriacao;
  final String titulo;
  final String descricao;
  final int idContratacaoServico;
  final int idCompraProduto;
  final int idCooperado;
  final int idPrestador;
  final int idFornecedor;

  NotificationModel({
    this.id,
    this.lida,
    this.dataCriacao,
    this.titulo,
    this.descricao,
    this.idContratacaoServico,
    this.idCompraProduto,
    this.idCooperado,
    this.idPrestador,
    this.idFornecedor,
  });

  NotificationModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        lida = map['lida'],
        dataCriacao = DateTime.parse(map['dataCriacao']),
        titulo = map['titulo'],
        descricao = map['descricao'],
        idContratacaoServico = map['idContratacaoServico'],
        idCompraProduto = map['idCompraProduto'],
        idCooperado = map['idCooperado'],
        idPrestador = map['idPrestador'],
        idFornecedor = map['idFornecedor'];

  Map<String, dynamic> toMap() => Map.from({
        "id": id,
        "lida": lida,
        "dataCriacao": dataCriacao.toString(),
        "titulo": titulo,
        "descricao": descricao,
        "idContratacaoServico": idContratacaoServico,
        "idCompraProduto": idCompraProduto,
        "idCooperado": idCooperado,
        "idPrestador": idPrestador,
        "idFornecedor": idFornecedor
      });

  @override
  String toString() {
    return '{id: $id, '
        'dataCriacao: $dataCriacao, '
        'titulo: $titulo, '
        'descricao: $descricao}';
  }
}

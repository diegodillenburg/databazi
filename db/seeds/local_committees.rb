local_committee_list = [
  ['ARACAJU', 100, 306817550],
  ['BALNEARIO CAMBORIU', 1731, 306820346],
  ['BAURU', 32, 306825623],
  ['BELEM', 12, 362628356],
  ['BELO HORIZONTE', 1248, 306810804],
  ['BLUMENAU', 2155, 362628487],
  ['BRASILIA', 1300, 306812018],
  ['CAMPO GRANDE', 1766, 306825376],
  ['CHAPECO', 283, 306822862],
  ['CUIABA', 2150, 336444212],
  ['CURITIBA', 1178, 306813088],
  ['FLORIANOPOLIS', 988, 306811093],
  ['FORTALEZA', 286, 306810283],
  ['FRANCA', 284, 306818036],
  ['GOIANIA', 434, 306817719],
  ['ITA', 1368, 306817098],
  ['ITAJUBA', 479, 306822498],
  ['JOAO PESSOA', 1666, 306824849],
  ['JOINVILLE', 232, 306818877],
  ['LIMEIRA(CAMPINAS)', 2061, 335437867],
  ['LONDRINA', 437, 306817769],
  ['MACEIO', 2149, 362629308],
  ['MANAUS', 231, 306817297],
  ['MARINGA', 723, 306811055],
  ['NATAL', 2151, 362629783],
  ['OURO PRETO', 1248, 306810804],
  ['PALMAS', 2343, 746674013],
  ['PELOTAS', 148, 306820564],
  ['PORTO ALEGRE', 854, 306810913],
  ['RECIFE', 541, 306810735],
  ['RIBEIRAO PRETO', 467, 306820937],
  ['RIO DE JANEIRO', 777, 306811119],
  ['SALVADOR', 1121, 306811026],
  ['SANTA MARIA', 958, 306813159],
  ['SANTAREM', 2153, 353882059],
  ['SANTOS', 1816, 306819356],
  ['SAO CARLOS', 435, 306812438],
  ['SAO CARLOS - ARARAQUARA', 435, 944542701],
  ['SAO CARLOS - PIRASSUNUNGA)', 435, 944543905],
  ['SAO JOSE DO RIO PRETO', 2147, 353885407],
  ['SAO LUIS', 2344, 746673297],
  ['SAO PAULO - UNIDADE ABC', 1647, 340039892],
  ['SAO PAULO - UNIDADE ESPM (Vila Mariana)', 436, 306812929],
  ['SAO PAULO - UNIDADE FGV (Bela Vista)', 943, 306822659],
  ['SAO PAULO - UNIDADE INSPER (Vila Olímpia)', 233, 306817462],
  ['SAO PAULO - UNIDADE MACKENZIE (Higienópolis)', 2152, 362629397],
  ['SAO PAULO - UNIDADE USP (Butantã)', 1003, 306811162],
  ['SOROCABA', 230, 306825137],
  ['TERESINA', 2098, 340037977],
  ['UBERLANDIA', 287, 306813291],
  ['VALE DO PARAIBA', 1368, 306817098],
  ['VALE DO SAO FRANCISCO - JUAZEIRO', 1649, 362630905],
  ['VALE DO SAO FRANCISCO - PETROLINA', 1649, 362630905],
  ['VITORIA', 909, 306810868],
  ['VIÇOSA', 2148, 362631010],
  ['VOLTA REDONDA', 289, 335438552]
]

local_committee_list.each do |name, expa_id, podio_id|
  LocalCommittee.create(
    name: name,
    expa_id: expa_id,
    podio_id: podio_id
  )
end

/**
  Retorna todos os pedidos de uma pessoa
 */
select pd.codigo_mesa,
       concat('R$ ', sum(p.preco_unitario_prato)) as valor_total,
       c.nome_cliente,
       m.data_hora_entrada,
       m.data_hora_saida
from tb_pedido pd
         inner join tb_prato p on pd.codigo_prato = p.codigo_prato
         inner join tb_mesa m on pd.codigo_mesa = m.codigo_mesa
         inner join tb_cliente c on m.id_cliente = c.id_cliente
where c.cpf_cliente = '301.845.972-50'
group by pd.codigo_mesa;

/**
  Retorna todos os pedidos por mesa
 */
select p.nome_prato,
       p.preco_unitario_prato,
       pd.quantidade_pedido,
       concat('R$ ', (p.preco_unitario_prato * pd.quantidade_pedido)) as valor_total
from tb_prato p
         inner join tb_pedido pd on p.codigo_prato = pd.codigo_prato
         inner join tb_mesa m on pd.codigo_mesa = m.codigo_mesa
where m.codigo_mesa = 47;


/**
  Qual o cliente que mais fez pedidos por ano
 */
select distinct
        c.nome_cliente,
       sum(quantidade_pedido) as soma_pedidos,
        '2024' as ano
from tb_pedido pd
         inner join tb_prato p on pd.codigo_prato = p.codigo_prato
         inner join tb_mesa m on pd.codigo_mesa = m.codigo_mesa
         inner join tb_cliente c on m.id_cliente = c.id_cliente
where year(m.data_hora_saida) = 2024
group by c.nome_cliente

union all
select distinct
    c.nome_cliente,
    sum(quantidade_pedido) as soma_pedidos,
    '2023' as ano
from tb_pedido pd
         inner join tb_prato p on pd.codigo_prato = p.codigo_prato
         inner join tb_mesa m on pd.codigo_mesa = m.codigo_mesa
         inner join tb_cliente c on m.id_cliente = c.id_cliente
where year(m.data_hora_saida) = 2023
group by c.nome_cliente
union all
select distinct
    c.nome_cliente,
    sum(quantidade_pedido) as soma_pedidos,
    '2022' as ano
from tb_pedido pd
         inner join tb_prato p on pd.codigo_prato = p.codigo_prato
         inner join tb_mesa m on pd.codigo_mesa = m.codigo_mesa
         inner join tb_cliente c on m.id_cliente = c.id_cliente
where year(m.data_hora_saida) = 2022
group by c.nome_cliente order by soma_pedidos desc;


/**
  Qual o cliente que mais gastou em todos os anos
 */
select
    concat('R$ ', sum(p.preco_unitario_prato * pd.quantidade_pedido)) as valor_total,
    c.nome_cliente
from tb_pedido pd
         inner join tb_prato p on pd.codigo_prato = p.codigo_prato
         inner join tb_mesa m on pd.codigo_mesa = m.codigo_mesa
         inner join tb_cliente c on m.id_cliente = c.id_cliente
group by c.nome_cliente order by valor_total desc;

/**
  Qual(is) o(s) cliente(s) que trouxe(ram) mais pessoas por ano
 */
select distinct
    c.nome_cliente,
    sum(m.num_pessoa_mesa) as quantidade_pessoas,
    '2024' as ano
from tb_pedido pd
         inner join tb_prato p on pd.codigo_prato = p.codigo_prato
         inner join tb_mesa m on pd.codigo_mesa = m.codigo_mesa
         inner join tb_cliente c on m.id_cliente = c.id_cliente
where year(m.data_hora_saida) = 2024
group by c.nome_cliente

union all
select distinct
    c.nome_cliente,
    sum(m.num_pessoa_mesa) as quantidade_pessoas,
    '2023' as ano
from tb_pedido pd
         inner join tb_prato p on pd.codigo_prato = p.codigo_prato
         inner join tb_mesa m on pd.codigo_mesa = m.codigo_mesa
         inner join tb_cliente c on m.id_cliente = c.id_cliente
where year(m.data_hora_saida) = 2023
group by c.nome_cliente
union all
select distinct
    c.nome_cliente,
    sum(m.num_pessoa_mesa) as quantidade_pessoas,
    '2022' as ano
from tb_pedido pd
         inner join tb_prato p on pd.codigo_prato = p.codigo_prato
         inner join tb_mesa m on pd.codigo_mesa = m.codigo_mesa
         inner join tb_cliente c on m.id_cliente = c.id_cliente
where year(m.data_hora_saida) = 2022
group by c.nome_cliente order by quantidade_pessoas desc;

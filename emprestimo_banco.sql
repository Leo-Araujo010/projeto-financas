select * from financial_loan;
-- KPI's Iniciais --
select count(id) as aplicacoes_emprestimos_totais
from financial_loan;

select count(id) as aplicacoes_totais_por_mes
from financial_loan
where month(issue_date) = 11 and year(issue_date) = 2021;

-- Montante financiado total --

select sum(loan_amount) as montante_total_financiado
from financial_loan;

-- mes atual --
select sum(loan_amount) as montante_total_financiado
from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021;

-- montante total recebido --

select sum(total_payment) as montante_total_recebido
from financial_loan;

-- montante recebido do mês em curso --
 
 select sum(total_payment) as mes_curso_montante
 from financial_loan
 where month(issue_date) = 12 and year(issue_date) = 2021;
 
 
 -- média da taxa de juros --
 
 select avg(int_rate)*100 as média_taxa_juros
 from financial_loan;
 
 -- média de juros no mês em curso --
 
  select avg(int_rate)*100 as média_taxa_juros_mes_curso
 from financial_loan
 where month(issue_date) = 11 and year(issue_date) = 2021;	
 
 -- Índice de Endividamento --
 
 select avg(dti)*100 as media_indice
 from financial_loan;
 
 -- Índice de Endividamento do mês em curso -- 
  select avg(dti)*100 as media_indice_mes_curso
 from financial_loan
 where month(issue_date) = 12 and year(issue_date) = 2021;
 
   select avg(dti)*100 as media_indice_mes_curso
 from financial_loan
 where month(issue_date) = 11 and year(issue_date) = 2021;
 
 
 -- Bom emprestimos --
 -- percentagem das aplicações que são bons emprestimos --
 select 
	(count(case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end)*100) 
    / 
    count(id) as porcentagem_bom_emprestimo
 from financial_loan;
 
 -- Bons emprestimos numero de aplicações --
 
select count(id) as aplicacoes_bom_emprestimo
 from financial_loan
 where loan_status = 'Fully Paid' or loan_status = 'Current';
 
 -- Montante Total Financiado (Empréstimo Bom) --
 
 select sum(loan_amount) as total_financiado_emprestimo_bom
 from financial_loan
 where loan_status = 'Fully Paid' or loan_status = 'Current';
 
 -- Montante Total Recebido (Empréstimo Bom) --
 
  select sum(total_payment) as total_recebido_emprestimo_bom
 from financial_loan
 where loan_status = 'Fully Paid' or loan_status = 'Current';
 
 -- Emprestimos ruins --
  -- percentagem das aplicações que são emprestimos ruins --
 select 
	(count(case when loan_status = 'CHarged Off' then id end)*100) 
    / 
    count(id) as porcentagem_emprestimo_ruim
 from financial_loan;
 
  -- Emprestimos ruins numero de aplicações --
 
select count(id) as aplicacoes_emprestimo_ruim
 from financial_loan
 where loan_status = 'CHarged Off';
 
 -- Montante Total Financiado (Empréstimo Ruim) --
 
 select sum(loan_amount) as total_financiado_emprestimo_ruim
 from financial_loan
 where loan_status = 'Charged Off';
 
  -- Montante Total Recebido (Empréstimo Ruim) --
 
  select sum(total_payment) as total_recebido_emprestimo_ruim
 from financial_loan
 where loan_status = 'Charged Off';
 
 -- Status dos emprestimos --
select loan_status,
	count(id) as numero_aplicacoes_emprestimos,
	sum(total_payment) as total_recebido,
	sum(loan_amount) as total_financiado,
	avg(int_rate *100) as taxa_juro,
	avg(dti*100) as indice_endividamento
from financial_loan
group by loan_status;

 -- status dos emprestimos do mês em curso --
select loan_status,
	sum(total_payment) as total_recebido_mes_curso,
	sum(loan_amount) as total_financiado_mes_curso
from financial_loan
where month(issue_date) = 12
group by loan_status; 

-- Relatorio dos emprestimos por mês --

select 
	month(issue_date) as numero_mes,
	date_format(issue_date, '%M') as nome_mes,
	count(id) as numero_aplicacoes_emprestimos,
	sum(total_payment) as total_recebido,
	sum(loan_amount) as total_financiado
from financial_loan
group by month(issue_date),date_format(issue_date, '%M')
order by month(issue_date);

-- Relatorio dos emprestimos por estado --

select 
	address_state as estado,
	count(id) as numero_aplicacoes_emprestimos,
	sum(total_payment) as total_recebido,
	sum(loan_amount) as total_financiado
from financial_loan
group by address_state
order by address_state;

-- Relatorio dos emprestimos por prazo --

select 
	term as prazo,
	count(id) as numero_aplicacoes_emprestimos,
	sum(total_payment) as total_recebido,
	sum(loan_amount) as total_financiado
from financial_loan
group by term
order by term;

-- Relatório dos emprestimos por longetividade do funcionario --

select 
	emp_length as anos_dos_funcionarios,
	count(id) as numero_aplicacoes_emprestimos,
	sum(total_payment) as total_recebido,
	sum(loan_amount) as total_financiado
from financial_loan
group by emp_length
order by emp_length;

-- Relatório dos emprestimos por finalidade de contrato --

select 
	purpose as finalidade,
	count(id) as numero_aplicacoes_emprestimos,
	sum(total_payment) as total_recebido,
	sum(loan_amount) as total_financiado
from financial_loan
group by purpose
order by purpose;

-- Relatório compra ou aluguel de imoveis --

select 
	home_ownership as transacao_imoveis,
	count(id) as numero_aplicacoes_emprestimos,
	sum(total_payment) as total_recebido,
	sum(loan_amount) as total_financiado
from financial_loan
group by transacao_imoveis
order by transacao_imoveis;
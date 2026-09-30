/*elementos cujos valores podem/irão alterar conforme o jogo progride*/
/*-------------------------------------------------------------------*/
:- dynamic novo/1.

:- dynamic duda_possui/1.
:- dynamic local_duda/1.
:- dynamic hora/1.
:- dynamic dia/1.
:- dynamic dinheiro/1.

:- dynamic casar/1.
:- dynamic genero_bebe/1.
:- dynamic nome_bebe/1.

:- dynamic torre/1.



/*declarações inicias dos estados dos elementos*/
/*---------------------------------------------*/
novo(0).

local_duda(patio).
hora(5).
dia(1).
dinheiro(300).
%controla quanto dinheiro Duda tem durante o jogo (não é possível adquirir mais)
duda_dinheiro(U):- dinheiro(K), assert(dinheiro(U)), retract(dinheiro(K)), write("Duda possui R$"), write(U), write(",00.").

%testa se Duda já visitou a torre e em que estado ela se encontra
torre(0).

casar(0).
genero_bebe(0).
%função que irá aleatoriamente (50/50 de chance) gerar um gênero para o bebê de Duda
genero_rand:- random(1, 3, R), retract(genero_bebe(0)), assert(genero_bebe(R)).

%define o nome base do bebê de Duda
nome_base:- genero_bebe(1), assert(nome_bebe(lucas_junior)).
nome_base:- genero_bebe(2), assert(nome_bebe(eduarda_junior)).



/*finais possíveis do jogo*/
/*------------------------*/

%final original
finalizado:- duda_possui(bessy), local_duda(galinheiro), casar(0).

%final alternativo onde Duda adquire uma descoberta a partir do pergaminho e isso a leva a deixar sua fazenda e ir embora
finalizado:- duda_possui(papel), casar(0).

%final alternativo onde Duda se casa e tem um bebê (270 dias = 9 meses)
finalizado:- casar(270).

/*loop principal do jogo*/
/*----------------------*/

%mensagem inicial que só aparece uma vez no começo do jogo
rodar:- novo(0), retract(novo(0)), write("Duda é uma humilde e alegre jovem. Ela possui uma pequena fazenda no campo, a qual havia herdado de seu pai, em um vilarejo simples e acolhedor."), nl, write("Ela tinha perdido toda sua família em um acidente há alguns anos. Seu pai e sua mãe haviam morrido, e sua irmã tinha desaparecido."), nl, write("Ela lembrava das palavras de sua mãe, sempre a dizendo para olhar a luz no fim do túnel, o arco-íris acima da tempestade."), nl, write("E é com essas palavras que ela nunca se deixou desmoronar, e sempre olhou para frente. Sempre otimista."), nl, write("Ela passava os dias trabalhando em sua fazenda, dando o máximo de si para cuidar daquele restante de paraíso na terra que possuía."), nl, write("Na vila em que Duda residia moravam também alguns aldeões. Duda costumava passear e conversar com eles, que eram sempre gentis e amigáveis para com ela."), nl, write("Um desses era Dona Lurdes, uma senhora que cuidou de Duda como uma filha desde que esta veio a se tornar órfã."), nl, write("Dona Lurdes possuía uma casinha em um rancho próximo à fazenda de Duda. Embora de idade já bem avançada, Dona Lurdes criava gado, principalmente galinhas."), nl, write("Um belo dia, Duda acordara em sua fazenda. O sol raiava e ela se levantou com um estranho pressentimento de que este seria um dia atípico."), nl, write("Ela se aprontou, pegou sua enxada e foi para o pátio de sua fazenda. De repente, Duda ouviu um grito vindo do rancho de Dona Lurdes..."), nl, rodar.

%testa se o final 1 foi alcançado
rodar:- finalizado, duda_possui(bessy), local_duda(galinheiro), write("Duda cumpriu sua missão de capturar Bessy e levá-la ao galinheiro!!!").

%testa se o final 2 foi alcançado
rodar:- finalizado, duda_possui(papel), write("Duda pegou o estranho papel na torre, e, como suspeitava, não se tratava de um pergaminho, mas sim uma carta antiga. Não estava selada, nem continha remetente ou destinatário. Ela a abriu cuidadosamente..."), nl, write("..."), nl, write("Porém, nada poderia preparar Duda para o susto que levou. Ela sentiu seu coração palpitar. Conforme seus olhos iam passando pela carta, letra a letra, sua respiração ia ficando cada vez mais pulsante."), nl, write("Após terminar de ler e reler a carta várias vezes, Duda levantou o olhar para a janela da torre e percebeu que havia ficado de noite. Ela saiu lentamente da torre, com olhar incrédulo, e com a mão agarrando fortemente o papel..."), nl, write("Alguns dias após o ocorrido, as notícias se espalharam pela vila. Os aldeões, com olhares tristes, haviam vindo até o ponto de ônibus, de madrugada."), nl, write("Eles vinham se despedir de Duda. A garota anunciara que iria se mudar para a cidade"), write("Entre acenos, abraços e lágrimas, o ronco do motor e o raiar do Sol anunciava, o ônibus se preparava para partir."), nl, write("Duda subiu no ônibus com suas malas, um olhar triste, mas esperança nos olhos."), nl, write("Em suas mãos estava a carta."), nl, write("Nela, em sua primeira linha, dizia:"), nl, write("Para Duda, de sua querida irmã...").

%testa se o final 3 foi alcançado
rodar:- finalizado, casar(A), A>269, nome_bebe(X), write("Após muito tempo, um belo dia, Duda acorda em sua casa com uma dor insuportável na barriga. Ela e Lucas se apressam para o hospital, onde encontram o doutor Carlos, que confirma com um olhar sério: 'Chegou a hora!'. Após muito esforço, nasce então um lindo bebê."), nl, write("Eles resolveram chamar a criança recém-nascida de "), write(X), write("."), nl, write(" Foi uma grande reviravolta que a vida de Duda deu. E agora um novo capítulo se inicia em sua vida."), nl, write("Ela alcançou o que nem mil galinhas, nem um milhão de fazendas, nem todo o dinheiro do mundo pode comprar. Felicidade!!!").

%caso o jogo não tenha finalizado, pede-se uma ação do usuário e então volta para o laço
rodar:- nl, write("O que Duda irá fazer agora?"), nl, read(X), call(X), nl, rodar.



/*controla a passagem de tempo (horas, dias)*/
/*------------------------------------------*/

%caso esteja no meio do dia(entre 0:00 e 22:00), apenas as horas irão avançar, de 1 em 1
tempo:- hora(A), A<23, dia(C), casar(0), B is A+1, assert(hora(B)), retract(hora(A)), write(B), write(":00 horas. "), write("Dia "), write(C), write(".").

%caso esteja no meio do dia(entre 0:00 e 22:00), apenas as horas irão avançar, de 1 em 1
tempo:- hora(A), A<23, dia(C), casar(X), X>0, B is A+1, assert(hora(B)), retract(hora(A)), write(B), write(":00 horas. "), write("Dia "), write(C), write(". "), write(X), write(" dias casada.").

%caso sejam 23:00, as horas passam a ser 0, o dia avança em 1, e, caso Duda não esteja casada, os "dias casada" não avança, e, caso Duda tenha tomado banho no dia anterior, ela não mais está "limpa" neste novo dia
tempo:- hora(A), A=23, dia(C), duda_possui(banho), casar(0), B is 0, D is C+1, assert(hora(B)), retract(hora(A)), assert(dia(D)), retract(dia(C)), retract(duda_possui(banho)), write(B), write(":00 horas. "), write("Dia "), write(D), write(".").

%caso sejam 23:00, as horas passam a ser 0, o dia avança em 1, e, caso Duda esteja casada, os "dias casada" avança em 1, e, caso Duda tenha tomado banho no dia anterior, ela não mais está "limpa" neste novo dia
tempo:- hora(A), A=23, dia(C), duda_possui(banho), casar(X), X>0, X<119, B is 0, D is C+1, Y is X+1, assert(hora(B)), retract(hora(A)), assert(dia(D)), retract(dia(C)), assert(casar(Y)), retract(casar(X)), retract(duda_possui(banho)), write(B), write(":00 horas. "), write("Dia "), write(D), write(". "), write(Y), write(" dias casada.").

%caso sejam 23:00, as horas passam a ser 0, o dia avança em 1, e, como Duda chegou a 4 meses de casada/gravidez, os "dias casada" avança em 1, e ela pode ir ao médico descobrir o gênero do bebê, e, caso Duda tenha tomado banho no dia anterior, ela não mais está "limpa" neste novo dia
tempo:- hora(A), A=23, dia(C), duda_possui(banho), casar(X), X=119, B is 0, D is C+1, Y is X+1, assert(hora(B)), retract(hora(A)), assert(dia(D)), retract(dia(C)), assert(casar(Y)), retract(casar(X)), retract(duda_possui(banho)), write(B), write(":00 horas. "), write("Dia "), write(D), write(". "), write(Y), write(" dias casada."), nl, write("Duda sente-se estranha hoje. Talvez ela devesse ir ao médico.").

%caso sejam 23:00, as horas passam a ser 0, o dia avança em 1, e, como Duda passou de 4 meses de casada/gravidez, os "dias casada" avança em 1, e o gênero do bebê já foi definido(apenas 1 vez!), e, caso Duda tenha tomado banho no dia anterior, ela não mais está "limpa" neste novo dia
tempo:- hora(A), A=23, dia(C), duda_possui(banho), casar(X), X>119, B is 0, D is C+1, Y is X+1, assert(hora(B)), retract(hora(A)), assert(dia(D)), retract(dia(C)), assert(casar(Y)), retract(casar(X)), assert(duda_possui(banho)), write(B), write(":00 horas. "), write("Dia "), write(D), write(". "), write(Y), write(" dias casada."), nl, write("Duda sente-se estranha hoje. Talvez ela devesse ir ao médico.").

%caso sejam 23:00, as horas passam a ser 0, o dia avança em 1, e, caso Duda não esteja casada, os "dias casada" não avança, e, como Duda não tomou banho, não há necessidade de "remover o banho" neste novo dia
tempo:- hora(A), A=23, dia(C), not(duda_possui(banho)), casar(0), B is 0, D is C+1, assert(hora(B)), retract(hora(A)), dia(C), D is C+1, assert(dia(D)), retract(dia(C)), write(B), write(":00 horas. "), write("Dia "), write(D).

%caso sejam 23:00, as horas passam a ser 0, o dia avança em 1, e, caso Duda esteja casada, os "dias casada" avança em 1, e, como Duda não tomou banho, não há necessidade de "remover o banho" neste novo dia
tempo:- hora(A), A=23, dia(C), not(duda_possui(banho)), casar(X), X>0, X<119, B is 0, D is C+1, Y is X+1, assert(hora(B)), retract(hora(A)), assert(dia(D)), retract(dia(C)), assert(casar(Y)), retract(casar(X)), write(B), write(":00 horas. "), write("Dia "), write(D), write(". "), write(Y), write(" dias casada.").

%caso sejam 23:00, as horas passam a ser 0, o dia avança em 1, e, como Duda chegou a 4 meses de casada/gravidez, os "dias casada" avança em 1, e ela pode ir ao médico descobrir o gênero do bebê, e, como Duda não tomou banho, não há necessidade de "remover o banho" neste novo dia
tempo:- hora(A), A=23, dia(C), not(duda_possui(banho)), casar(X), X=119, B is 0, D is C+1, Y is X+1, assert(hora(B)), retract(hora(A)), assert(dia(D)), retract(dia(C)), assert(casar(Y)), retract(casar(X)), write(B), write(":00 horas. "), write("Dia "), write(D), write(". "), write(Y), write(" dias casada."), nl, write("Duda sente-se estranha hoje. Talvez ela devesse ir ao médico.").

%caso sejam 23:00, as horas passam a ser 0, o dia avança em 1, e, como Duda passou de 4 meses de casada/gravidez, os "dias casada" avança em 1, e o gênero do bebê já foi definido(apenas 1 vez!), e, como Duda não tomou banho, não há necessidade de "remover o banho" neste novo dia
tempo:- hora(A), A=23, dia(C), not(duda_possui(banho)), casar(X), X>119, B is 0, D is C+1, Y is X+1, assert(hora(B)), retract(hora(A)), assert(dia(D)), retract(dia(C)), assert(casar(Y)), retract(casar(X)), write(B), write(":00 horas. "), write("Dia "), write(D), write(". "), write(Y), write(" dias casada."), nl, write("Duda sente-se estranha hoje. Talvez ela devesse ir ao médico.").



/*controla a situação com base no lugar onde Duda se encontra*/
/*-----------------------------------------------------------*/

%situação em que Duda está em sua fazenda, onde ela pode passar o tempo
lugar:- local_duda(fazenda), write("Duda amava sua vida na fazenda. Andar sobre a grama do pasto, observar os frutos nascendo da colheita. Ela nunca iria se cansar desse lugar."), nl, write("E não havia nada que ela gostava mais de fazer do que simplesmente estar em sua linda casinha, olhando através da janela do quarto as estrelas do céu noite após noite."), nl, write("Gostaria de passar o tempo?"), nl, read(X), fazenda(X).


%situação em que Duda está na beira do lago
lugar:- local_duda(lagoa), write("Duda olha da beira do lago. Ela vinha nadar nele quase todo dia quando era criança."), nl, write("Ela observa a água cristalina. As carpas e girinos a convidam para ENTRAR na água.").
%situação em que Duda está na orla da praia
lugar:- local_duda(praia), write("Duda olha para o mar. Ela veio nadar aqui tantas vezes quando era criança."), nl, write("Ela observa as ondas do mar e as gaivotas do céu, chamando-a para ENTRAR na água.").
%situação em que Duda está na entrada do spa
lugar:- local_duda(spa), write("Duda olha a porta do spa. Ela vinha relaxar aqui todo final de semana quando era criança."), nl, write("Ela observa os clientes em roupa de banho, entrando e saindo com sorrisos no rosto. O aroma de cidreira a impulsiona a ENTRAR.").


%situação em que Duda entra na casa de Dona Lurdes, sem ter pegado rede
lugar:- local_duda(casa_dentro), not(duda_possui(bessy)), not(duda_possui(rede)), casar(0), write("Dona Lurdes: Oh... D...Duda. Olá. Você veio m... me socorrer? Obrigada."), nl, write("Dona Lurdes: Minha g... g... galinha premiada, Bessy, fugiu. Ela s... sempre foi a mais a... arteira do galinheiro."), nl, write("Dona Lurdes: Oh. Por favor, você p.... poderia ir c... capturá-la para mim? Pode PEGAR a r... rede que eu tenho aqui.").
%situação em que Duda entra na casa de Dona Lurdes, após ter pegado a rede, mas ainda não ter capturado a galinha
lugar:- local_duda(casa_dentro), duda_possui(rede), not(duda_possui(bessy)), casar(0), write("Dona Lurdes: Oh... D...Duda. Muito o... obrigada por me a... aj... ajudar."), nl, write("Dona Lurdes: V... Você sempre f... foi tão boazinha p... pra mim.").
%sitaçao em que Duda entra na casa de Dona Lurdes, após ter capturado a galinha Bessy
lugar:- local_duda(casa_dentro), duda_possui(bessy), casar(0), write("Dona Lurdes: Ah! B... Bessy! Aí está ela."), nl, write("Dona Lurdes: Muitíssimo o... o... obrigada, minha querida."), nl, write("Dona Lurdes: P... Por favor, leve-a ao galinheiro pra mim.").
% sitaçao ao entrar na casa de Dona Lurdes, caso Duda tenha se casado
lugar:- local_duda(casa_dentro), casar(X), X>0, write("Dona Lurdes: Duda..."), nl, write("Dona Lurdes: É v... verdade? Você e pequeno Lucas?..."), nl, write("Dona Lurdes: Oh! Que dia m... mais feliz! Minha Dudinha s... se casou!"), nl, write("Dona Lurdes: Estou tão f... feliz e orgulhosa de você, minha q... querida."), nl, write("E tenho c... certeza que seus p... p... pais também estariam.").


%situação em que Duda visita a torre pela primeira vez
lugar:- local_duda(torre), torre(0), assert(torre(1)), retract(torre(0)), write("Ao entrar na velha torre, as memórias começam sutilmente a voltar para Duda. Ela e sua irmã escalando as paredes, brincando de aventureiras, folheando os tomos velhos das estantes."), nl, write("Tempos que se perderam, apenas restando as boas lembranças e a saudade..."), nl, write("Ao voltar a si, Duda nota um pequeno pergaminho no alto do mesanino da torre. Ela não conseguia alcançá-lo, mas se perguntava: o que será que poderia estar escrito nele."), nl, write("Talvez escrituras antigas ou talvez uma história não contada. O cuidador do museu local certamente iria querer saber."), nl, write("Mas a velha escadaria que subia até o andar superior estava quebrada, e o edifício todo em si estava ruínas. Duda se perguntou então como ela iria subir até lá.").
%situação em que Duda já visitou a torre
lugar:- local_duda(torre), torre(X), X>0, write("Duda observava curiosa o pergaminho no alto do mesanino. Como ela poderia chegar até lá?").


%situação ao entrar na marcenaria, caso Duda tenha visitado a torre (diálogo aparace apenas uma vez)
lugar:- local_duda(marcenaria_dentro), torre(1), not(duda_possui(madeira)), assert(torre(2)), retract(torre(1)), write("Marceneira Joane: Ah, você foi até aquela torre velha? Sei lá há quanto tempo está lá. Talvez seja mais antiga que a própria vila. Hohoho."), nl, write("Marceneira Joane: Nossa! Eu me lembro, há uns 10 anos atrás, sua mãe tinha sonho de transformar a estrutura num centro de caridade, mas o projeto não foi pra frente."), nl, write("Marceneira Joane: Acho que cuidar de você e sua irmã tomou mais precedência na vida dela. Hohoho.").
%sitaçao ao entrar na marcenaria, caso Duda tenha madeira para consertar a torre, mas não tenha dinheiro (ou seja, não é possível fazer o final 2)
lugar:- local_duda(marcenaria_dentro), duda_possui(madeira), dinheiro(0), casar(0), write("Marceneira Joane: Hm? Consertar a velha torre? Não recomendaria, minha querida. O prédio já está todo caindo aos pedaços. Hohoho."), nl, write("Marcenaria Joane: Mas eu te entendo. Você e sua irmãzinha eram fissuradas naquele lugar. Iam brincar lá o dia inteiro. Como sua mãe ficava preocupada. Hohoho."), nl, write("Marceneira Joane: Sabe quem sempre queria brincar com vocês, mas tinha vergonha? Aquele seu amiguinho Lucas. O garoto sempre foi tão tímido...").
%sitaçao ao entrar na marcenaria, caso Duda tenha madeira para consertar a torre
lugar:- local_duda(marcenaria_dentro), duda_possui(madeira), dinheiro(X), X>0, write("Marceneira Joane: Hm? Consertar a velha torre? Não recomendaria, minha querida. O prédio já está todo caindo aos pedaços. Hohoho."), nl, write("Marcenaria Joane: Mas eu te entendo. Você e sua irmãzinha eram fissuradas naquele lugar. Talvez um retorno ao passado possa acalmar seu coração."), nl, write("Marceneira Joane: Entretanto, antes de mais nada, eu precisaria de madeira para esse trabalho.").
%situação base ao entrar na marcenaria
lugar:- local_duda(marcenaria_dentro), write("Marceneira Joane: Olá Duda! Tudo bem com você? Nossa como você cresceu. Eu me lembro de quando sua mãe veio aqui me apresentar as filhinhas dela pela primeira vez. Hohoho.").


%situação base (solteira) ao entrar na loja. Sempre irá pedir uma resposta
lugar:- local_duda(loja_dentro), casar(0), not(duda_possui(anel)), write("Lojista Lucas: Ah! Duda! Como está você?"), nl, read(X), loja(X).
%situação base (solteira) ao entrar na loja, tendo o anel em sua posse
lugar:- local_duda(loja_dentro), casar(0), duda_possui(anel), write("Lojista Lucas: Olá, Duda... Sabe, você sempre vem visitar a loja. Eu nunca pude expressar direito a gratidão que sinto."), nl, write("Lojista Lucas: Eu sou muito grato por sempre poder ver você. Seu rosto, seu sorriso."), nl, write("Lojista Lucas: Me dá ânimo pra continuar vindo aqui todos os dias.").
%situação ao entrar na loja, uma vez que Duda sabe que será um menino, sendo requerido agora que decida um nome
lugar:- local_duda(loja_dentro), genero_bebe(menino), nome_bebe(lucas_junior), write("Lojista Lucas: O que?! O doutor disse que é um menino?"), nl, write("Oh, nunca estive tão feliz em toda a minha vida! Como vamos chamá-lo, meu amor?"), nl, read(B), assert(nome_bebe(B)), retract(nome_bebe(lucas_junior)), nl, write("Lojista Lucas: "), write(B), write("? Esse é um excelente nome!").
%situação ao entrar na loja, uma vez que Duda sabe que será uma menina, sendo requerido agora que decida um nome
lugar:- local_duda(loja_dentro), genero_bebe(menina), nome_bebe(eduarda_junior), write("Lojista Lucas: O que?! O doutor disse que é uma menina?"), nl, write("Lojista Lucas: Oh, nunca estive tão feliz! Como vamos chamá-la, meu amor?"), nl, read(B), assert(nome_bebe(B)), retract(nome_bebe(eduarda_junior)), nl, write("Lojista Lucas: "), write(B), write("? Esse é um excelente nome!").
%situação base ao entrar na loja, caso Duda tenha se casado.
lugar:- local_duda(loja_dentro), casar(X), X>0, write("Lojista Lucas: Oh!... Olá amor. Como você está?").


%situação ao entrar na ferraria, caso Duda tenha ouro em sua posse
lugar:- local_duda(ferraria_dentro), duda_possui(ouro), dinheiro(K), K>99, write("Ferreiro Zé Paulo: Óia só, rapaz! Uma baita mineradora de sorte, igual seu véio pai. Que ele descanse em paz."), nl, write("Ferreiro Zé Paulo: Talvez eu pudesse forjar algo procê com esse ouro. Que me diz?"), nl, write("R$100,00 - Forjar anel?"), nl, read(X), ferraria(X).
%situação ao entrar na ferraria, caso Duda tenha se casado
lugar:- local_duda(ferraria_dentro), casar(A), A>0, write("Ferreiro Zé Paulo: Ah, Dudinha... Ouvi que ocê e o mulequinho Lucas se casaram. Har har har. Parece que as nossa criança cresceram, não é mesmo. Har har har."), nl, write("Ferreiro Zé Paulo: Seu pai ficaria tão orgulhoso de ocê. Ele sempre buscava o melhor pras fia dele.").
%situação ao entrar na ferraria, caso tenha comprado uma picareta e um machado
lugar:- local_duda(ferraria_dentro), duda_possui(picareta), duda_possui(machado), write("Ferreiro Zé Paulo: Ô menininha trabalhadora, rapaz. Puxou seu pai mermo. Har har har"), nl, write("Ferreiro Zé Paulo: Lembro quando ele vinha aqui me pedir pra dar um trato no ancinho enferrujado dele."), nl, write("Ferreiro Zé Paulo: A gente batia uns papo por horas a fim. Ô época boa que num volta, bixo...").
%situação ao entrar na ferraria, caso não tenha comprado as ferramentas
lugar:- local_duda(ferraria_dentro), write("Ferreiro Zé Paulo: Opa, Duda. Tá Boa? Qué comprar umas ferramenta?"), nl, write("R$100,00 - picareta"), nl, write("R$100,00 - machado").


%situação ao entrar no hospital, caso Duda tenha acabado de se casar
lugar:- local_duda(hospital_dentro), casar(A), A>0, A<120, write("Doutor Carlos: Oh, Duda! Lucas me contou tudo. O garoto está numa euforia incrível esses dias. Nunca o vi tão feliz."), nl, write("Doutor Carlos: Vocês são amigos desde criança, não é? Eu não poderia estar mais orgulhoso dos dois."), nl, write("É como ver dois filhotes de passarinho finalmente alçando voo...").
%situação ao entrar no hospital, caso Duda tenha se casado e tenham se passado 4 meses. Aqui pede-se uma resposta para averiguar o gênero do bebê
lugar:- local_duda(hospital_dentro), casar(A), A>119, not(genero_bebe(menino)), not(genero_bebe(menina)), write("Doutor Carlos: Oh, Duda! Ouvi as boas novas. Você veio fazer o teste?"), nl, read(X), hospital(X).
%situação base ao entrar no hospital
lugar:- local_duda(hospital_dentro), write("Doutor Carlos: Olá, Duda? Espero que esteja se sentindo bem. Como posso ajudar?").


%situação em que Duda está em um lugar sem ações possíveis
lugar:- local_duda(X), write("Duda está em "), write(X), write(".").



   /*loop: quando Duda está em sua fazenda, pergunta-se se ela quer passar o tempo*/
   /*-----------------------------------------------------------------------------*/

   %caso uma resposta diferente de 'sim' ou 'não' seja escrita (continua o laço)
   fazenda(X):- X\=sim, X\=nao, write("Duda às vezes pensava sobre o futuro. O tempo parecia não passar para ela. A vida era, de fato, uma coisa linda."), nl, write("Gostaria de passar o tempo?"), nl, read(Y), fazenda(Y).

   %caso 'sim' seja escrito (pede-se um número de dias para passar o tempo)
   fazenda(X):- X=sim, write("Quantos dias se passaram?"), nl, read(Y), passar_o_tempo(Y).

   %caso 'não' seja dito (finaliza o laço)
   fazenda(X):- X=nao, write("Duda olha para sua frente, com olhar forte."), nl, write("Ela sabia, que se havia de planejar o futuro, ela deveria construir o presente.").


      %Se o número digitado for negativo, o tempo não volta pra trás
      passar_o_tempo(X):- X<0, write("Duda às vezes se via pensando no passado. As ondas de nostalgia por vezes tomavam o melhor dela, e levavam lágrimas a lentamente escorrer de seu rosto."), nl, write("Nesses momentos, Duda se lembrava das palavras de seu pai, dizendo-a para não chorar pelo que já passou, mas se alegrar pelo que está por vir."), nl, write("Afinal, não há momento como o presente.").

      %Se Duda não estiver casada, passam-se apenas os dias
      passar_o_tempo(X):- dia(A), casar(0), D is A+X, assert(dia(D)), retract(dia(A)), write("Passaram-se "), write(X), write(" dias.").

      %Se Duda não estiver casada, é pedido um número, que é adicionado ao número de dias de gravidez, porém caso esse número exceda 9 meses, a ação d      e passar o tempo não é realizada, pois levaria Duda a dar à luz após um número possivelmente muito maior de dias
      passar_o_tempo(X):- casar(B), B>0, E=B+X, E>269, write("Porém, ela estava apreensiva ultimamente. Sabia que 'O Dia' estava próximo. Ela não conseguia relaxar por muito tempo.").

      %caso Duda esteja casada, é pedido um número, e este é adicionado ao número atual de dias passados e ao número de dias de gravidez (contanto que      este não exceda o período de gestação de 9 meses)
      passar_o_tempo(X):- dia(A), casar(B), B>0, D is A+X, E is B+X, E<270, assert(dia(D)), retract(dia(A)), assert(casar(E)), retract(casar(B)), write("Passaram-se "), write(X), write(" dias.").


   /*loop: diálogo (solteira) com o lojista Lucas*/
   /*--------------------------------------------*/

   %caso uma resposta diferente de 'bem' ou 'mal' seja dita (continua o laço)
   loja(X):- X\=bem, X\=mal, write("Lojista Lucas: O que? Não entendi."), nl, read(Y), loja(Y).

   %caso 'bem' seja dito (finaliza o laço)
   loja(X):- X=bem, write("Lojista Lucas: Ah, que bom. Não são tantas pessoas que vem à loja recentemente. Fico tão feliz por sua visita. Como posso ajudar?").

   %caso 'mal' seja dito (finaliza o laço)
   loja(X):- X=mal, write("Lojista Lucas: O QUE? Sério? Aww... Deve ter algo que eu possa fazer para poder trazer seu sorriso de volta.").


   /*loop: diálogo com o ferreiro Zé Paulo*/
   /*-------------------------------------*/

   %caso uma resposta diferente de 'sim' ou 'não' seja dita (continua o laço)
   ferraria(X):- X\=sim, X\=nao, write("Ferreiro Zé Paulo: Cuméquié? Foi mal, Dudinha, a audição do véio Paulo não é mais a merma."), nl, read(Y), ferraria(Y).

   %caso 'sim' seja dito (finaliza o laço)
   ferraria(X):- X=sim, dinheiro(K), U is K-100, duda_dinheiro(U), nl, write("Ferreiro Zé Paulo: É assim que se fala, minha querida. Rapaz, hoje o véio Paulo tá inspirado. Tá afim de trabáio, bixo."), nl, write("Espera um pouquinho que a minha obra prima vai ficar pronta. Afinal a pequena Dudinha merece o melhor."), nl, write("..."), nl, assert(duda_possui(anel)), retract(duda_possui(ouro)), write("Pronto. Se me permite dizer, é o mais puro e belo anel que já foi feito nessa terra."), nl, write("Espero que ocê dê ele pra alguém muito especial, viu?").

   %caso 'não' seja dito (finaliza o laço)
   ferraria(X):- X=nao, write("Ferreiro Zé Paulo: É? Tá bom, então. Ocê que manda. Har har har").


   /*loop: diálogo com o doutor Carlos, sobre fazer o teste do gênero do bebê*/
   /*------------------------------------------------------------------------*/

   %caso uma resposta diferente de 'sim' ou 'não' seja dita (continua o laço)
   hospital(X):- X\=sim, X\=nao, write("Doutor Carlos: O que? Perdão, poderia repetir?"), nl, read(Y), hospital(Y).

   %caso 'não' seja dito (apenas finaliza o laço)
   hospital(X):- X=nao, write("Doutor Carlos: Oh. Tudo bem. Como posso ajudar?").

   %caso 'sim' seja dito e o bebê seja um menino (finaliza o laço)
   hospital(X):- X=sim, genero_bebe(1), write("Doutor Carlos: Muito bem, espere um instante."), assert(genero_bebe(menino)), retract(genero_bebe(1)), nl, write("Doutor Carlos: Hoho! Duda, tenho ótimas notícias para você. É um menino! Você deveria ir à loja e contar a Lucas. Por acaso já pensaram num nome?").

   %caso 'sim' seja dito e o bebê seja uma menina (finaliza o laço)
   hospital(X):- X=sim, genero_bebe(2), write("Doutor Carlos: Muito bem, espere um instante."), assert(genero_bebe(menina)), retract(genero_bebe(2)), nl, write("Doutor Carlos: Ahá! Duda, tenho ótimas notícias para você. É uma menina! Você deveria ir à loja e contar a Lucas. Por acaso já pensaram num nome?").



/*ações que o jogador pode tomar com respeito a itens*/
/*---------------------------------------------------*/

%quando Duda tenta dar um item que não possui
dar(X):- not(duda_possui(X)), write("Duda não tem esse item para dar para alguem.").

%quando Duda tenta dar um item que não é possível no jogo
dar(X):- X\=madeira, X\=anel, write("Duda tentou dar algo impossível.").


%quando Duda tenta dar a madeira para Joana, mas não está na marcenaria
dar(X):- X=madeira, duda_possui(madeira), not(local_duda(marcenaria_dentro)), write("Duda não está na marcenaria para ordenar uma escada.").

%quando Duda tenta dar a madeira para Joana, mas não possui dinheiro
dar(X):- X=madeira, duda_possui(madeira), not(local_duda(marcenaria_dentro)), dinheiro(0), write("Duda não possui dinheiro suficiente para ordenar uma escada.").

%Duda compra uma escada
dar(X):- X=madeira, duda_possui(madeira), local_duda(marcenaria_dentro), dinheiro(K), K>100, U is K-100, assert(dinheiro(U)), retract(dinheiro(K)), retract(duda_possui(madeira)), write("Marceneira Joana: Muito bem. Vou começar a construir uma escada sob medida. Só um instante..."), nl, write("..."), nl, write("Prontinho. Uma escada no capricho. Bon appétit. Hohoho"), assert(duda_possui(escada)).


%quando Duda tenta dar o anel para Lucas, mas não está em sua loja
dar(X):- X=anel, duda_possui(anel), not(local_duda(loja_dentro)), write("Duda não está na loja para propor para Lucas.").

%inicia o laço em que Duda e Lucas podem se casar
dar(X):- X=anel, duda_possui(anel), local_duda(loja_dentro), write("Lojista Lucas: Duda, eu... Desde o primeiro momente em que te vi, meu coração nunca mais me deu paz... Minha mente só pensava em você. O tempo todo."), nl, write("Será possível?... Você se sente da mesma forma?"), nl, read(A), lucas(A).

   %caso uma resposta diferente de 'sim' ou 'não' seja dita (continua o laço, a partir desse ponto)
   lucas(A):- A\=sim, A\=nao, write("O que? Eu... Não entendi... Argh, o que estou fazendo?... Por favor Duda, me responda. Por favor. Você me ama?"), nl, read(C), lucas(C).

   %caso 'não' seja dito (apenas finaliza o laço)
   lucas(A):- A=nao, write("O QUE?... Eu... Eu..."), nl, write("..."), nl, write("Eu peço mil desculpas... Acabei me precipitando..."), nl, write("Me... Me perdoe Duda...").

   %Duda é declarada casada, e tem-se inicio o processo para se chegar ao final 3
   lucas(A):- A=sim, assert(casar(1)), retract(casar(0)), retract(duda_possui(anel)), write("Duda e Lucas se casaram!"), nl, genero_rand, nome_base, write("O que será que o futuro reserva para Duda?").



%quando Duda tenta pegar a rede, mas não está dentro da casa
pegar(X):- not(local_duda(casa_dentro)), X=rede, write("Duda não está na casa de Dona Lurdes para pegar a rede.").
%quando Duda pega a rede dentro da casa
pegar(X):- local_duda(casa_dentro), X=rede, assert(duda_possui(X)), write("Duda adquiriu a rede!").


%quando Duda tenta pegar a galinha, mas não está na floresta
pegar(X):- not(local_duda(floresta)), X=bessy, write("Duda não está na floresta para capturar a galinha Bessy.").
%quando Duda tenta pegar a galinha na floresta, mas não possui a rede
pegar(X):- local_duda(floresta), not(duda_possui(rede)), X=bessy, write("Duda não possui a rede para capturar a galinha Bessy.").
%quando Duda pega a galinha Bessy
pegar(X):- local_duda(floresta), duda_possui(rede), X=bessy, assert(duda_possui(X)), write("Duda capturou a galinha Bessy!").


%quando Duda tenta pegar madeira, mas não está na floresta
pegar(X):- not(local_duda(floresta)), X=madeira, write("Duda não está na floresta para coletar madeira.").
%quando Duda tenta pegar madeira na floresta, mas não possui o machado
pegar(X):- local_duda(floresta), not(duda_possui(machado)), X=madeira, write("Duda não possui o machado para coletar madeira.").
%quando Duda corta e pega madeira
pegar(X):- local_duda(floresta), duda_possui(machado), X=madeira, assert(duda_possui(X)), write("Duda coletou madeira!").


%quando Duda tenta pegar ouro, mas não está na mina
pegar(X):- not(local_duda(mina)), X=ouro, write("Duda não está dentro da mina para mineirar ouro.").
%quando Duda tenta pegar ouro na mina, mas não possui picareta
pegar(X):- local_duda(mina), X=ouro, not(duda_possui(picareta)), write("Duda não possui uma picareta para mineirar ouro.").
%quando Duda já mineirou ouro na mina antes
pegar(X):- local_duda(mina), X=ouro, (duda_possui(ouro); duda_possui(anel); (casar(F),F>0)), write("Duda lembrou-se de quando coletou aquele minério de ouro na mina. Foi de fato um dia único.").
%quando Duda consegue mineirar ouro, mas não tomou banho hoje (passa o tempo)
pegar(X):- local_duda(mina), X=ouro, duda_possui(picareta), not(duda_possui(banho)), assert(duda_possui(X)), write("Duda bateu a picareta nas pedras por alguns instantes e os rumores se provaram verdadeiros. Aquela era de fato uma riquíssima mina de ouro."), nl, write("Duda então coletou com suas mãos um pouco de ouro.").
%quando Duda consegue mineirar ouro, mas tomou banho hoje (passa o tempo e muda o estado de Duda para "suja")
pegar(X):- local_duda(mina), X=ouro, duda_possui(picareta), duda_possui(banho), assert(duda_possui(X)), write("Duda bateu a picareta nas pedras por alguns instantes e os rumores se provaram verdadeiros. Aquela era de fato uma riquíssima mina de ouro."), nl, write("Duda então coletou com suas mãos um pouco de ouro."), retract(duda_possui(banho)).


%quando Duda tenta comprar uma picareta ou um machado, mas não está na ferraria
pegar(X):- not(local_duda(ferraria_dentro)), (X=picareta;X=machado), write("Duda não está na ferraria para comprar ferramentas.").
%quando Duda tenta comprar uma picareta ou um machado, mas não possui dinheiro suficiente
pegar(X):- local_duda(ferraria_dentro), dinheiro(K), K<100, (X=picareta;X=machado), write("Duda não possui dinheiro suficiente para comprar isso.").
%quando Duda consegue comprar uma picareta ou um machado
pegar(X):- local_duda(ferraria_dentro), dinheiro(K), K>99, (X=picareta;X=machado), assert(duda_possui(X)), write("Duda comprou "), write(X), write("!"), nl, U is K-100, duda_dinheiro(U).


%quando Duda tenta pegar o pergaminho, mas não está dentro da torre
pegar(X):- not(local_duda(torre)), X=papel, write("Duda não está na torre para pegar o pergaminho.").
%quando Duda tenta pegar o pergaminho na torre, mas não possui a escada
pegar(X):- local_duda(torre), X=papel, not(duda_possui(escada)), write("Duda olhou para aquele curioso papel no alto do mesanino. Curiosamente, não parecia tão antigo e decomposto de longe."), nl, write("Mas Duda iria precisar de algo para alcançá-lo. Talvez uma escada...").
%quando Duda pega o pergaminho
pegar(X):- local_duda(torre), X=papel, duda_possui(escada), assert(duda_possui(X)).


%quando Duda tenta pegar qualquer coisa que não existe no jogo
pegar(X):- X=X, write("Duda tentou pegar algo impossível.").



/*define os caminhos que podem ser tomados (de onde pra onde)*/
/*-----------------------------------------------------------*/

%do patio pra fazenda
acessivel(X,Y):- X=patio, local_duda(X), Y=fazenda.
%da fazenda de volta pro pátio
acessivel(X,Y):- X=fazenda, local_duda(X), Y=patio.

%do patio pra casa
acessivel(X,Y):- X=patio, local_duda(X), Y=casa.
%da casa de volta pro patio
acessivel(X,Y):- X=casa, local_duda(X), Y=patio.

%do patio pra floresta
acessivel(X,Y):- X=patio, local_duda(X), Y=floresta.
   %da floresta pra torre
   acessivel(X,Y):- X=floresta, local_duda(X), Y=torre.
   %da torre de volta pra floresta
   acessivel(X,Y):- X=torre, local_duda(X), Y=floresta.
%da floresta de volta pro patio
acessivel(X,Y):- X=floresta, local_duda(X), Y=patio.

%do patio pra lagoa
acessivel(X,Y):- X=patio, local_duda(X), Y=lagoa.
%da lagoa de volta pro patio
acessivel(X,Y):- X=lagoa, local_duda(X), Y=patio.

%do patio pro galinheiro
acessivel(X,Y):- X=patio, local_duda(X), Y=galinheiro.
%do galinheiro de volta pro patio
acessivel(X,Y):- X=galinheiro, local_duda(X), Y=patio.

%do patio pra cidade
acessivel(X,Y):- X=patio, local_duda(X), Y=cidade.
   %da cidade pra loja
   acessivel(X,Y):- X=cidade, local_duda(X), Y=loja.
   %da loja de volta pra cidade
   acessivel(X,Y):- X=loja, local_duda(X), Y=cidade.
   %da cidade pro hospital
   acessivel(X,Y):- X=cidade, local_duda(X), Y=hospital.
   %do hospital de volta pra cidade
   acessivel(X,Y):- X=hospital, local_duda(X), Y=cidade.
   %da cidade pra ponte
   acessivel(X,Y):- X=cidade, local_duda(X), Y=ponte.
      %da ponte pra praia
      acessivel(X,Y):- X=ponte, local_duda(X), Y=praia.
      %da praia de volta pra ponte
      acessivel(X,Y):- X=praia, local_duda(X), Y=ponte.
      %da ponte pra ferraria
      acessivel(X,Y):- X=ponte, local_duda(X), Y=ferraria.
      %da ferraria de volta pra ponte
      acessivel(X,Y):- X=ferraria, local_duda(X), Y=ponte.
   %da ponte de volta pra cidade
   acessivel(X,Y):- X=ponte, local_duda(X), Y=cidade.
%da cidade de volta pro patio
acessivel(X,Y):- X=cidade, local_duda(X), Y=patio.

%do patio pro caminho
acessivel(X,Y):- X=patio, local_duda(X), Y=caminho.
   %do caminho pra marcenaria
   acessivel(X,Y):- X=caminho, local_duda(X), Y=marcenaria.
   %da marcenaria de volta pro caminho
   acessivel(X,Y):- X=marcenaria, local_duda(X), Y=caminho.
   %do caminho pro spa
   acessivel(X,Y):- X=caminho, local_duda(X), Y=spa.
   %do spa de volta pro caminho
   acessivel(X,Y):- X=spa, local_duda(X), Y=caminho.
   %do caminho pra mina
   acessivel(X,Y):- X=caminho, local_duda(X), Y=mina.
   %da mina de volta pro caminho
   acessivel(X,Y):- X=mina, local_duda(X), Y=caminho.
%do caminho de volta pro patio
acessivel(X,Y):- X=caminho, local_duda(X), Y=patio.



/*define alguns lugares específicos (no geral edifícios), onde pode-se entrar e sair*/
/*----------------------------------------------------------------------------------*/

%entrar dentro da casa
entravel(X,Y):- X=casa, local_duda(casa), Y=casa_dentro.
%entrar dentro da loja
entravel(X,Y):- X=loja, local_duda(loja), Y=loja_dentro.
%entrar dentro do hospital
entravel(X,Y):- X=hospital, local_duda(hospital), Y=hospital_dentro.
%entrar dentro da ferraria
entravel(X,Y):- X=ferraria, local_duda(ferraria), Y=ferraria_dentro.
%entrar dentro da marcenaria
entravel(X,Y):- X=marcenaria, local_duda(marcenaria), Y=marcenaria_dentro.


%sair da casa
saivel(X,Y):- X=casa_dentro, local_duda(casa_dentro), Y=casa.
%sair da loja
saivel(X,Y):- X=loja_dentro, local_duda(loja_dentro), Y=loja.
%sair do hospital
saivel(X,Y):- X=hospital_dentro, local_duda(hospital_dentro), Y=hospital.
%sair da ferraria
saivel(X,Y):- X=ferraria_dentro, local_duda(ferraria_dentro), Y=ferraria.
%sair da marcenaria
saivel(X,Y):- X=marcenaria_dentro, local_duda(marcenaria_dentro), Y=marcenaria.



/*controla o deslocamento para lugares acessíveis. Apenas é possível se locomover de fato para locais abertos(pátio, cidade, caminho,...))*/
/*----------------------------------------------------------------------------------------------------------------------------------------*/

%caso Duda tente ir para dentro do "lugar fechado" em que está, é dito que é necessário "ENTRAR" deste lugar (não muda o lugar e não passa o tempo)
ir_para(Y):- ((local_duda(casa),Y=casa);(local_duda(torre),Y=torre_dentro);(local_duda(loja),Y=loja);(local_duda(hospital),Y=hospital);(local_duda(ferraria),Y=ferraria);(local_duda(marcenaria),Y=marcenaria)), write("Duda fora educada a sempre bater à porta. Ela inclina a mão sobre a maçaneta para ENTRAR em "), write(Y), write(".").

%caso Duda tente ir para fora do "lugar fechado" em que está, é dito que é necessário "SAIR" deste lugar (não muda o lugar e não passa o tempo)
ir_para(Y):- Y=Y, (local_duda(casa_dentro);local_duda(torre_dentro);local_duda(loja_dentro);local_duda(hospital_dentro);local_duda(ferraria_dentro);local_duda(marcenaria_dentro)), write("Embora sua visita seja sempre bem vinda à todos da cidade, Duda sabe que há coisas que ela precisa de fazer. Ela então se apronta para SAIR.").

%caso todas as condições sejam satisfeitas, Duda vai para o lugar determinado (muda o lugar e o tempo também)
ir_para(Y):- local_duda(X), acessivel(X,Y), assert(local_duda(Y)), retract(local_duda(X)), write("Duda foi de "), write(X), write(" para "), write(Y), write("."), nl, tempo, nl, lugar.

%caso Duda tente ir para um lugar que não seja possível (não muda o lugar e não passa o tempo)
ir_para(Y):- Y=Y, write("Duda tentou ir para algum lugar impossível.").



/*controla algumas entradas e saídas específicas em locais específicos (não passa o tempo)*/
/*----------------------------------------------------------------------------------------*/

%caso Duda entre para tomar banho na lagoa
entrar(Z):- local_duda(lagoa), Z=lagoa, assert(duda_possui(banho)), write("Duda mergulha na água. Ela se lembra da primeira vez que pulou naquele lago, quando seu pai havia acabado de comprar aquela fazenda."), nl, write("Muitos anos se passaram desde aquele dia. Muitas coisas mudaram, outras não. Será que ela era uma delas?").

%caso Duda entre para tomar banho na praia
entrar(Z):- local_duda(praia), Z=praia, assert(duda_possui(banho)), write("Duda entra lentamente na água do mar. Ela se lembra de todas as vezes que sua mãe a levou a praia quando era mais nova."), nl, write("Ela sempre adorou quando o vento balançava seus cabelos e as ondas a levavam de um lado pro outro.").

%caso Duda entre para tomar banho no spa
entrar(Z):- local_duda(spa), Z=spa, assert(duda_possui(banho)), write("Duda entra no spa da vila. Ela e sua irmã mais nova sempre vinham para relaxar lá nos fins de semana."), nl, write("Ela sentia falta de sua família, mas não importa o que acontecesse em sua vida, ela sempre seguia em diante, com um olhar otimista.").


%caso Duda tente entrar na casa, mas não tenha tomado banho
entrar(Z):- entravel(X,Y), X=casa, Y=casa_dentro, Z=casa, not(duda_possui(banho)), write("Duda sabia que não era educado entrar na casa de alguém sem tomar banho primeiro.").

%caso Duda tente entrar no hospital, mas não tenha tomado banho
entrar(Z):- entravel(X,Y), X=hospital, Y=hospital_dentro, Z=hospital, not(duda_possui(banho)), write("Duda sabia que não era educado entrar em um hospital sem tomar banho primeiro.").

%caso Duda tente entrar na marcenaria mas não tenha tomado banho
entrar(Z):- entravel(X,Y), X=marcenaria, Y=marcenaria_dentro, Z=marcenaria, not(duda_possui(banho)), write("Duda sabia que não deveria entrar num local de trabalho sem tomar banho primeiro.").

%caso Duda tente entrar na ferraria mas não tenha tomado banho
entrar(Z):- entravel(X,Y), X=ferraria, Y=ferraria_dentro, Z=ferraria, not(duda_possui(banho)), write("Duda sabia que não deveria entrar num ambiente de trabalho sem tomar banho primeiro.").


%caso satisfeitas as condições, Duda pode entrar nos lugares especificados, possibilitando novas situações e ações
entrar(Z):- entravel(X,Y), Z=X, assert(local_duda(Y)), retract(local_duda(X)), write("Duda entrou em "), write(Z), write("."), nl, lugar.


%caso Duda tente ir para um lugar que não seja possível
entrar(Z):- Z=Z, write("Duda tentou entrar em um lugar impossível.").



% caso seja possível, Duda pode sair dos lugares em que entrou
sair(Z):- local_duda(X), saivel(X,Z), assert(local_duda(Z)), retract(local_duda(X)), write("Duda saiu para "), write(Z), write("."), nl, lugar.


%caso contrário
sair(Z):- Z=Z, write("Duda tentou sair para um lugar impossível.").

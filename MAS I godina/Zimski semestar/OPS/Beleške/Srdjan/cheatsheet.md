Sadrzaj:
* [Formule](#formule)
* [Termini](#termini)
* [Testovi](#testovi)
  * [Zakljucivanje](#zakljucivanje)
  * [t-testovi](#t-testovi)
    * [Studentov t-test](#studentov-t-test)
    * [Nezavisni t-test](#nezavisni-t-test)
    * [Upareni t-test](#upareni-t-test)
    * [Man-Vitnijev test](#man-vitnijev-test)
    * [Vilkoksonov test](#vilkoksonov-test)
  * [Jedno kategorijsko, vise od dve grupe ili merenja](#jedno-kategorijsko-vise-od-dve-grupe-ili-merenja)
    * [ANOVA](#anova)
    * [Kruskal-Volisov test](#kruskal-volisov-test)
    * [ANOVA za ponovljena merenja](#anova-za-ponovljena-merenja)
    * [Fridmanov test](#fridmanov-test)
  * [Dva kategorijska, vise od dve grupe](#dva-kategorijska-vise-od-dve-grupe)
    * [Dvofaktorska ANOVA](#dvofaktorska-anova)
  * [Pomocni testovi](#pomocni-testovi)
    * [Levinov test](#levinov-test)

---    

# Formule

| Oznaka          | Opis                                        | Formula                                                               |
|:---------------:|:-------------------------------------------:|:---------------------------------------------------------------------:|
| $n$             | obim uzorka                                 |                                                                       |
| $m$             | aritmeticka sredina                         |                                                                       |
| $M$             | medijana                                    |                                                                       |
| $\bar{X_{n}}$   | srednju vrednost uzorka                     | $\displaystyle\frac {1} {n} \sum_{i=1}^n {X_{i}}$                     |
| $\bar{S_{n}}$   | uzoracka standardna devijacija (odstupanje) | $\sqrt {\bar{S_{n}^2}}$                                               |
| $\bar{S_{n}^2}$ | disperzija uzorka                           | $\displaystyle\frac {1} {n} \sum_{i=1}^n {(X_{i} - \bar{X_{n}})^2}$   |
| $\hat{S_{n}^2}$ | korigovana disperzija uzorka                | $\displaystyle\frac {1} {n-1} \sum_{i=1}^n {(X_{i} - \bar{X_{n}})^2}$ |

# Termini


| Termin | Opis |
|:---------------:|:----------------:|
| Stepen slobode | koristimo kao parametar pri citanju vrednosti granice kriticnog regionana osnovu vrednosti test statistike |
| Homogenost varijanse | varijanse su jednake |

# Testovi

Pri testiranju imamo sledece vrednosti:
* `p-value`: opisuje statisticki znacaj dobijenog zakljucka
  * ovako se obicno i oznacava
  * dobija se kao rezultat testa u R-u
  * na osnovu poredjenja sa alfa (nivo znacajnosti) biramo odgovarajucu hipotezu
* `vrednost test statistike`: broj koji predstavlja rezultat test statistike
  * koristimo je kada rucno vrsimo racun
  * proverava se da li se nalazi u kriticnom regionu i na osnovu toga biramo hipotezu
* `vrednost za odgovarajucu tehniku`: vrednost koja predstavlja neku osobinu ili zakljucak
  * koristimo je nakon sto zakljuckom testa potvrdimo da postoji ta neka osobina
  * primer: korelacija izmedju neka 2 obelezja


## Zakljucivanje

Zakljucivanje (R testovi):
1. Izbor testa
2. Odredjivanje $\alpha$
   * ako nije navedemo, koristimo vrednost `0.05`
3. Izbor alternativne hipoteze
4. Vrsimo test
5. Poredimo p-value i $\alpha$
   * ako je $\text{p-value} > \alpha$, prihvatamo $H_{0}$
   * ako je $\text{p-value} \le \alpha$, prihvatamo $H_{1}$

---
   
Zakljucivanje (rucno testiranje):
1. Izbor testa
2. Odredjivanje $\alpha$
   * ako nije navedemo, koristimo vrednost `0.05`
3. Izbor alternativne hipoteze
4. Racunamo **test statistiku**
5. Proveravamo da li vrednost test statistike (oznacene kao `t`), upada u kriticni region (oznacen sa `C`)
   * ako je $t \notin C$, prihvatamo $H_{0}$
   * ako je $t \in C$, prihvatamo $H_{1}$

## t-testovi

### Studentov t-test

* Parametarski test.
* Testira da li je sredina populacije neki odredjeni broj

---

#### Uslovi
* 1 neprekidno obelezje jednog uzorka
* posmatrano obelezje ima normalnu raspodelu

---

#### Nulta hipoteza

Sredine je (jednaka vrednosti) $m_{0}$:

$$
H_{0}(m=m_{0})
$$

---

#### Test statistika

$$
t_{n-1} = \frac {\bar{x_{n}} - m_{0}} {\displaystyle\frac {\hat{S_{n}}} {\sqrt{n}}}
$$

Ima Studentovu t raspodelu ([link do tabele](slike/studentova-raspodela.png)) sa $n-1$ stepenom slobode.

---

|  Kriticna oblast                                                   | Alternativna hipoteza |
|:------------------------------------------------------------------:|:---------------------:|
| $C = (- \infty, -t_{n-1, \alpha}) \cup (t_{n-1, \alpha}, +\infty)$ | $H_{1}(m \ne 0)$      |
| $C = (t_{n-1, 2\alpha}, +\infty)$                                  | $H_{1}(m > 0)$        |
| $C = (- \infty, -t_{n-1, 2\alpha})$                                | $H_{1}(m < 0)$        |

### Nezavisni t-test

* parametarska alternativa za [Man-Vitnijev test](#man-vitnijev-test)
* testira da li postoji razlika izmedju 2 populacije (jednake sredine) za dato obelezje

---

#### Uslovi
* **po** 1 neprekidno obelezje iz 2 uzorka/populacije/grupe
* posmatrano obelezje **ima** normalnu raspodelu
* **(opciono, ali pozeljno)** homogenost varijanse

---

#### Nulta hipoteza 

Sredine u obe grupe su jednake:

$$
\begin{gather*}
H_{0}(m = 0) \\
ili \\
H_{0}(m_{1} = m_{2})
\end{gather*}
$$

gde je $m_{1}$ sredina jednog uzorka, a $m_{2}$ sredina drugog, a $m = m_{1} - m_{2}$.

---

#### Test statistika

$$
t = 
\frac 
    {\bar{X_{n_{1}}} - \bar{X_{n_{2}}}}
    {\displaystyle\sqrt {
      \displaystyle\frac {(n_{1}-1)\hat{S_{1}^2} + (n_{2}-1)\hat{S_{2}^2}} {n_{1}+n_{2}-2} 
      \left(\frac {1} {n_{1}} + \frac {1} {n_{2}}\right)
      }
    }
$$

Ima Studentovu t raspodelu ([link do tabele](slike/studentova-raspodela.png)) sa $n_{1} + n_{2} - 2$ stepenom slobode.

---

|  Kriticna oblast                                                   | Alternativna hipoteza |
|:------------------------------------------------------------------:|:---------------------:|
| $C = (- \infty, -t_{n_{1} + n_{2} - 2, \alpha}) \cup (t_{n_{1} + n_{2} - 2, \alpha}, +\infty)$ | $H_{1}(m \ne 0)$      |
| $C = (t_{n_{1} + n_{2} - 2, 2\alpha}, +\infty)$                                  | $H_{1}(m > 0)$        |
| $C = (- \infty, -t_{n_{1} + n_{2} - 2, 2\alpha})$                                | $H_{1}(m < 0)$        |


### Upareni t-test

* parametarska alternativa za [Vilkoksonov test](#vilkoksonov-test)
* testira da li postoji razlika izmedju 2 merenja (jednake sredine) za dato obelezje

---

#### Uslovi
* 2 merenja nad **istom** populacijom
* 1 neprekidno obelezje u oba merenju
* obelezje ima **normalnu raspodelu** u **oba** merenja

---

#### Nulta hipoteza

Sredina u prvom merenju je jednaka sredinu u drugom (sredine u merenjima 
su jednake):

$$
\begin{gather*}
H_{0}(D=0) \\
ili \\
H_{0}(m_{1} = m_{2})
\end{gather*}
$$

$D = m_{1} - m_{2}$ uvedena nova oznaka radi izbegavanja preklapanja oznaka

---

#### Test statistika

$$
t_{n-1} = \frac {\bar{D_{n}}} {\displaystyle\frac {\hat{S_{n}}} {\sqrt{n}}} 
$$

Ima Studentovu t raspodelu ([link do tabele](slike/studentova-raspodela.png)) sa $n - 1$ stepenom slobode.

---

|  Kriticna oblast                                                   | Alternativna hipoteza |
|:------------------------------------------------------------------:|:---------------------:|
| $C = (- \infty, -t_{n-1, \alpha}) \cup (t_{n-1, \alpha}, +\infty)$ | $H_{1}(m \ne 0)$      |
| $C = (t_{n-1, 2\alpha}, +\infty)$                                  | $H_{1}(m > 0)$        |
| $C = (- \infty, -t_{n-1, 2\alpha})$                                | $H_{1}(m < 0)$        |

### Man-Vitnijev test

* neparametarska alternativa za [Nezavisni t-test](#nezavisni-t-test)
* testira da li postoji razlika izmedju 2 populacije (jednake medijane) za dato obelezje

---

#### Uslovi
* **po** 1 neprekidno obelezje iz 2 uzorka/populacije/grupe
---

#### Nulta hipoteza 

Nema razlike izmedju medijana:

$$
\begin{gather*}
H_{0}(M = 0) \\
ili \\
H_{0}(M_{1} = M_{2})
\end{gather*}
$$

gde je $M_{1}$ medijana jednog uzorka, a $M_{2}$ medijana drugog, a $M = M_{1} - M_{2}$.

---

#### Test statistika

$$
T_{n_{1}} = \displaystyle\sum_{k=1}^{n_1} r_{x_{k}}
$$

gde je $(x_{1}, x_{2}, \dots,  x_{n_{1}})$ uzorak koji ima **manji obim**, 
$n_{1}$ njegov obim, a $r_{k}$ rang `k`. clana tog uzorka.

---

|  Kriticna oblast                                                 | Alternativna hipoteza |
|:----------------------------------------------------------------:|:---------------------:|
| $C = (0, T_{n_{1}, n_{2}}^a) \cup (T_{n_{1}, n_{2}}^b, +\infty)$ | $H_{1}(M \ne 0)$      |

---

#### Test

Tabela:

![Man-Vitnijeva U tabela](slike/man-vitnijeva-tabela.png)

### Vilkoksonov test

* neparametarska alternativa za [Upareni t-test](#upareni-t-test)
* testira da li postoji razlika izmedju 2 merenja (jednake medijane) za dato obelezje
* https://www.statology.org/wilcoxon-signed-rank-test
  * **Napomena**: za igrace 1, 8, 10, 11 i 15 je `3` zato sto 
  je to vrednost proseka njihovih pozicija u varijacionom nizu, tj.
  `suma = 3+4+5+6+7 = 15`, `n = 5`, pa je `rank = suma/n = 15/5 = 3`
---

#### Uslovi
* 2 merenja nad **istom** populacijom
* **po** 1 neprekidno obelezje iz 2 merenja

#### Nulta hipoteza 

Medijane su po merenjima jednake:

$$
H_{0}(M=0)
$$

---

#### Test statistika

$$
T_{n,\alpha}=\min\left(\sum{\text{pozitivni rangovi}} ,  \left| \sum{\text{negativni rangovi}} \right| \right)
$$

---

|  Kriticna oblast                                                 | Alternativna hipoteza |
|:----------------------------------------------------------------:|:---------------------:|
| $C = (-\infty, T_{n, \alpha}]$ | $H_{1}(M \ne 0)$ |

#### Test

1. rangiranje apsolutnih vrednosti razlika izmedju 2 merenja ispitanika
2. rangu se dodeljuje znak razlike
3. sabiranje posebno pozitivnih i negativnih rangova (2 sume)
4. test statistika: $\min\left(\sum{\text{pozitivni rangovi}} \;  \left| \sum{\text{negativni rangovi}} \right| \right)$
5. granice za kriticni region se citaju iz tablice koja je predvidjena za ovaj test
6. prihvatanje neke hipoteze


Ako imamo iste vrednosti, njihov rang predstavlja prosek njihovih
pozicija u var. nizu.

Ako nema promena (razlika 0), onda se dati element ne posmatra
dalje u algoritmu i ne racuna u ukupan broj elemenata (`n` ce se smanjiti
onoliko koliko ima ovakvih elemenata).

## Jedno kategorijsko, vise od dve grupe ili merenja

* [Razlika izmedju F-raspodele i Chi-square](https://i.sstatic.net/NDlm4.png)

---

### ANOVA

* parametarska alternativa za [Kruskal-Volisov test](#kruskal-volisov-test)
* testira da li postoji razlika po datom obelezju
  u tri ili vise grupe (arit. sredina)

---

#### Uslovi

* **kategorijsko obelezje** koje razbija uzorak na **3 ili vise grupe**
* **neprekidno obelezje** koje se meri u svakoj od tih grupa
* **zavisno** neprekidno obelezje treba da **ima normalnu raspodelu u svakoj od grupa**
* (pozeljno, ali moze da se zanemari) **homogenost** posmatranih grupa

#### Nulta hipoteza

Sredine svih grupa su jednake:

$$
H_{0}(m_{1}=m_{2}=m_{3}=\dots=m_{k})
$$

---

#### Test statistika

$$
\begin{gather*}
SS_{wg} = \displaystyle\sum_{j=1}^{k} \displaystyle\sum_{i=1}^{n_{j}} (x_{ji} - \bar{x}_{j})^2 \\
ili \\
SS_{wg} = \displaystyle\sum_{j=1}^{k} \displaystyle\sum_{i=1}^{n_{j}} x_{ji}^2 - \displaystyle\sum_{j=1}^{k} n_{j} \bar{x}_{j}^2
\end{gather*}
$$

$$
SS_{bg} = \displaystyle\sum_{j=1}^{k} n_{j} (\bar{x_{j}} - x_{tot})^2
$$

Stepeni slobode za:
* sumu kvadrata izmedju grupa: $d_{f_{bg}}=k-1$
* sumu kvadrata unutar grupa: $d_{f_{wg}}=n-k$

$$
MS_{wg}=\frac{SS_{wg}}{d_{f_{wg}}}
$$

$$
MS_{bg}=\frac{SS_{bg}}{d_{f_{bg}}}
$$

Definicija test statistike:

$$
F = \frac{MS_{bg}}{MS_{wg}} \sim F_{k-1, n-k}
$$

Ima raspodelu $F$ ([link do tabela](slike/f-raspodela/)) sa stepenima slobode 
$d_1 = k-1$ i $d_2 = n-k$.


---

|  Kriticna oblast                                                   | Alternativna hipoteza |
|:------------------------------------------------------------------:|:---------------------:|
| $C = (f, +\infty)$ | $H_{1}((\exists i, j) m_i \ne m_j))$      |

gde je $f$ vrednost test statistike.

### Kruskal-Volisov test

* neparametarska alternativa za [ANOVA-u](#ANOVA)
* testira da li postoji razlika po datom obelezju
  u tri ili vise grupe (medijana)

---

#### Uslovi

* **kategorijsko obelezje** koje razbija uzorak na **3 ili vise grupe**
* **neprekidno obelezje** koje se meri u svakoj od tih grupa

---

#### Nulta hipoteza

Medijane po grupama su jednake:

$$
H_{0}(M_1 = M_2 = M_3 = \dots = M_k)
$$

---

#### Test statistika

$$
H = \frac{12}{n(n+1)} \displaystyle\sum_{i=1}^{k} \frac{R_{i}^2}{n_{i}} - 3 (n+1)
$$

gde je $R_{i} = \displaystyle\sum_{j=1}^{n_i} r_{x_{ij}}$, tj. suma rangova svih elemenata $i$-te grupe, 
a $n_{i}$ kardinalnost $i$-te grupe.

Ima $\chi^2$ (hi kvadrat) raspodelu ([link do tabele](slike/hi-kvadrat.png)) sa stepenom slobode $k-1$.

---

|  Kriticna oblast                                                   | Alternativna hipoteza |
|:------------------------------------------------------------------:|:---------------------:|
| $C = (\chi_{k-1;\alpha}^2, +\infty)$ | $H_{1}((\exists i, j) M_i \ne M_j))$      |

### ANOVA za ponovljena merenja

Ne radi se na papiru.

### Fridmanov test

Ne radi se na papiru.

## Dva kategorijska, vise od dve grupe

### Dvofaktorska ANOVA

* nema odgovarajuce (bar ne jednostavne) neparametarske alternative
* testira da li postoji razlika na odredjenom neprekidnom obelezuju izmedju 
  grupa koje su dobijene razbijanjem uzorka pomocu 2 kategorijska obelezja 

---

#### Uslovi

* 2 **kategorijska obelezja** koja razbijaju uzorak na **vise grupa**
* 1 **neprekidno obelezje** koje se meri u svakoj od tih grupa
* (pozeljno, ali se u praksi zanemaruje) **zavisno** neprekidno obelezje treba da 
  **ima normalnu raspodelu u svakoj od grupa**
* (pozeljno, ali moze da se zanemari) **homogenost** posmatranih grupa

---

#### Test statistika

$$
SS_{AB} = SS_{bg} - SS_{A} - SS_{B}
$$

$$
SS_{T} = SS_{bg} + SS_{wg}
$$

Ovo je jedinstven test koji ima 3 test statistike.

Stepeni slobode za:
* sumu kvadrata izmedju grupa: $d_{f_{SS_{wg}}}=n-r*s$
* sumu kvadrata unutar grupa: $d_{f_{SS_{bg}}}=r*s-1$, gde je $s$ obim grupe A, a $r$ obim grupe B
* sumu kvadrata unutar grupa: $d_{f_{SS_{A}}}=s-1$, gde je $s$ obim grupe A
* sumu kvadrata unutar grupa: $d_{f_{SS_{B}}}=r-1$, gde je $r$ obim grupe B

---

##### Prva

###### Nulta hipoteza

Nulta hipoteza testa za intrakciju izmedju faktora:

$$
H_{0} (\text{Ne postoji interakcija medju faktorima})
$$

###### Formula

$$
MS_{AB} = \frac{  SS_{AB} } { d_{f_{wg} } } 
$$

Test statistika koja se bavi interakcijom:

$$
F_{int} = \frac{  MS_{AB} } { MS_{wg} } \sim F_{(r-1)(s-1); N-rs}
$$

Ima raspodelu $F$ ([link do tabela](slike/f-raspodela/)) sa stepenima slobode 
$d_1 = (r-1)(s-1)$ i $d_2 = n-rs$.

###### Opis testa

U slucaju da se prihvati $H_1$, tj. da ima interakcije, vrsimo fiksiranje jednog faktora
i analiziramo kako taj faktor utice na pojedinacne grupe drugog faktora.

Fiksiranje se vrsi u skladu sa potrebama problema.

---

##### Druga

Koristi se tek kada se prihvati $H_0$ u prvoj, tj. kada utvrdimo da nema interakcije.

Radi se 1-way ANOVA ili nezavisni t-test.

###### Nulta hipoteza

Sredine izmedju grupa prvog faktora su jednake:

$$
H_{0} (m_1 = m_2 = \dots = m_s)
$$

###### Formula

$$
F_{A} = \frac{  MS_{fA} } { d_{f_{wg} } } \sim F_{s-1; N-rs}
$$

Ima raspodelu $F$ ([link do tabela](slike/f-raspodela/)) sa stepenima slobode 
$d_1 = s-1$ i $d_2 = n-rs$.

---

##### Treca

Koristi se tek kada se prihvati $H_0$ u prvoj, tj. kada utvrdimo da nema interakcije.

Radi se 1-way ANOVA ili nezavisni t-test.

###### Nulta hipoteza

Sredine izmedju grupa drugog faktora su jednake:

$$
H_{0} (m_1^{\prime} = m_2^{\prime} = \dots = m_s^{\prime})
$$

###### Formula

$$
F_{B} = \frac{  MS_{fB} } { d_{f_{wg} } } \sim F_{r-1; N-rs} 
$$

Ima raspodelu $F$ ([link do tabela](slike/f-raspodela/)) sa stepenima slobode 
$d_1 = r-1$ i $d_2 = n-rs$.

#### Kriticna oblast

|  Kriticna oblast                                                   | Alternativna hipoteza |
|:------------------------------------------------------------------:|:---------------------:|
| $C = (f, +\infty)$ | $H_{1}((\exists i, j) m_i \ne m_j))$      |

gde je $f$ vrednost test statistike.

## Pomocni testovi

### Levinov test

* ispituje homogenost varijansi
* koristi se pri izboru nezavisnog t-testa

#### Nulta hipoteza

Varijanse su jednake u obe populacije:

$$
H_{0}(\sigma_{1}^2 = \sigma_{2}^2)
$$

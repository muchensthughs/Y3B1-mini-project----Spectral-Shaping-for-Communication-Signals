
[d,const_sym] = get_sym(64,'qpsk');
mu = 1.5;
a=1;
epsilon0 = 0.00001;
epsiloni = 0.00000000001;
            for k = 1:10
                v=0.00000005*10^k;
                t(k,1) =v;
                initialtime = cputime;
                [s,sf,sfup,l]= barrier_window(d,8,[9:15],mu,v,epsiloni,a);           
                time(k,1) = cputime - initialtime;
                it(k,1) = l;
            end
            figure
            [hAx,hLine1,hLine2] = plotyy(10*log10(t),time,10*log10(t),it);
            str = sprintf('cputime/iterations vs initial t with epsiloni=%d,epsilon0=%d,mu=%d',...
                epsiloni,epsilon0,mu);
            title(str);
            xlabel('log(epsiloni)')
            ylabel(hAx(1),'cputime/s');
            ylabel(hAx(2),'no of iterations of t');


           



//Código obtenido de: https://wiki.scilab.org/MandelbrotSet-NaiveVsVectorized
//Modificado por Marcelo Cantú y Bernardo Treviño


function R = computeMandelbrotVect(xtam,ytam,nmax,xmin,xmax,ymin,ymax)
    xvect = linspace( xmin, xmax, xtam );
    yvect = linspace( ymin, ymax, ytam );
    [X,Y]=meshgrid(xvect,yvect);

    Z = zeros(xtam,ytam);
    R = -ones(xtam,ytam);
    W = zeros(xtam,ytam);
    C=X+%i*Y;
    J = 1:xtam*ytam;
    for k=0:nmax
        L = J(J>0);
        Z(L) = Z(L).^2+C(L);
        W(L) = abs(Z(L));
        M = find(W(L)>2);
        R(L(M)) = k;
        J(L(M)) = 0;
    end
    R = R';
    // The maximum number of colors
    CMAX = 10000;
    grafica=gcf();
    grafica.color_map = jetcolormap(CMAX);
    D = R;
    k = find(R<>-1);
    D(k) = floor(R(k)/max(R(k))*CMAX);
    k = find(R==-1);
    D(k) = CMAX;
    Matplot(D);
    grafica.children.isoview="on";
    grafica.children.axes_visible=["off" "off" "off"];
endfunction

stacksize(5000000);
xtam = 200;
ytam = 200;
nmax = 2000;
xmin = 0.2675;
xmax = 0.2685;
ymin = 0.591;
ymax = 0.592;

tic();
R = computeMandelbrotVect(xtam,ytam,nmax,xmin,xmax,ymin,ymax);

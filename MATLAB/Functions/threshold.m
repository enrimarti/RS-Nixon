function [sim] = treshold (sim, j)
    sim(sim<j)=0;

end


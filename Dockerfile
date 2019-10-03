FROM "jupyter/minimal-notebook"

USER root

ENV JULIA_VERSION=1.1.1
RUN sudo apt-get update && apt-get install libcairo2 zlib1g-dev zlib1g gettext -y

RUN mkdir /opt/julia-${JULIA_VERSION} && \
    cd /tmp && \
    wget -q https://julialang-s3.julialang.org/bin/linux/x64/`echo ${JULIA_VERSION} | cut -d. -f 1,2`/julia-${JULIA_VERSION}-linux-x86_64.tar.gz && \
    tar xzf julia-${JULIA_VERSION}-linux-x86_64.tar.gz -C /opt/julia-${JULIA_VERSION} --strip-components=1 && \
    rm /tmp/julia-${JULIA_VERSION}-linux-x86_64.tar.gz

RUN ln -fs /opt/julia-*/bin/julia /usr/local/bin/julia

USER $NB_UID

# Add packages and precompile
# RUN julia -e 'import Pkg; Pkg.add("BinDeps"); using BinDeps' && \    
#     julia -e 'import Pkg; Pkg.add(Pkg.PackageSpec(url="https://github.com/giordano/Cairo.jl.git#binary-builder")); Pkg.build("Cairo"); using Cairo' && \ 
#         fix-permissions /home/$NB_USER
RUN julia -e 'import Pkg; Pkg.add("BinDeps"); using BinDeps' && \    
    julia -e 'import Pkg; Pkg.add("Cairo"); Pkg.build("Cairo"); using Cairo' && \ 
        fix-permissions /home/$NB_USER

RUN julia -e 'import Pkg; Pkg.update()' && \
    julia -e 'import Pkg; Pkg.add("Plots"); using Plots' && \
    # julia -e 'import Pkg; Pkg.add("PlotlyJS"); using PlotlyJS' && \
    julia -e 'import Pkg; Pkg.add("Distributions"); using Distributions' && \
    julia -e 'import Pkg; Pkg.add("Optim"); using Optim' && \     
    julia -e 'import Pkg; Pkg.add("IJulia"); using IJulia' && \
    fix-permissions /home/$NB_USER

# RUN julia -e 'import Pkg; Pkg.add(Pkg.PackageSpec(url="https://github.com/probcomp/Gen")); using Gen' && \    
    # julia -e 'import Pkg; Pkg.add(Pkg.PackageSpec(url="https://github.com/rohanmclure/ArrayChannels.jl")); using ArrayChannels' && \    
RUN julia -e 'import Pkg; Pkg.add("DifferentialEquations"); using DifferentialEquations' && \    
    julia -e 'import Pkg; Pkg.add("Flux"); using Flux' && \   
    # julia -e 'import Pkg; Pkg.add(PackageSpec(url="https://github.com/probcomp/Gen")); using Gen' && \    
    # julia -e 'import Pkg; Pkg.add("Turing"); using Turing' && \    
    # julia -e 'import Pkg; Pkg.add("Stheno"); using Stheno' && \    
    # julia -e 'import Pkg; Pkg.add("Stheno"); using Stheno' && \    
    # julia -e 'import Pkg; Pkg.add("Stheno"); using Stheno' && \    
    # julia -e 'import Pkg; Pkg.add("Stheno"); using Stheno' && \    
    # julia -e 'import Pkg; Pkg.add("Knet"); using Knet' && \    
    # julia -e 'import Pkg; Pkg.add("BenchmarkTools"); using BenchmarkTools' && \    
    # julia -e 'import Pkg; Pkg.add("Hydra"); using Hydra' && \    
    # julia -e 'import Pkg; Pkg.add("BSON"); using BSON' && \    
    # julia -e 'import Pkg; Pkg.add("StatsPlots"); using StatsPlots' && \    
    # julia -e 'import Pkg; Pkg.add("LightGraphs"); using LightGraphs' && \    
    julia -e 'import Pkg; Pkg.add("ModelingToolkit"); using ModelingToolkit' && \    
    fix-permissions /home/$NB_USER


# RUN  julia -e 'import Pkg; Pkg.add("Turing"); using Turing' && \    
#   RUN julia -e 'import Pkg; Pkg.add("Stheno"); using Stheno' && \    
    # julia -e 'import Pkg; Pkg.add("Stheno"); using Stheno' && \    
    # julia -e 'import Pkg; Pkg.add("Stheno"); using Stheno' && \    
    # julia -e 'import Pkg; Pkg.add("Stheno"); using Stheno' && \    
    # julia -e 'import Pkg; Pkg.add("Knet"); using Knet' && \    
RUN julia -e 'import Pkg; Pkg.add("BenchmarkTools"); using BenchmarkTools' && \    
    # julia -e 'import Pkg; Pkg.add("Hydra"); using Hydra' && \    
    julia -e 'import Pkg; Pkg.add("BSON"); using BSON' && \    
    julia -e 'import Pkg; Pkg.add("StatsPlots"); using StatsPlots' && \    
    julia -e 'import Pkg; Pkg.add("LightGraphs"); using LightGraphs' && \    
    julia -e 'import Pkg; Pkg.add("Revise"); using Revise' && \    
    julia -e 'import Pkg; Pkg.add("DataStructures"); using DataStructures' && \  
    julia -e 'import Pkg; Pkg.add("Zygote"); using Zygote' && \    
    # julia -e 'import Pkg; Pkg.activate("/home/jovyan/work/rls"); using rls' && \    
    # julia -e 'import Pkg; Pkg.add("ModelingToolkit"); using ModelingToolkit' && \    
    fix-permissions /home/$NB_USER

RUN julia -e 'import Pkg; Pkg.add("Reexport"); using Reexport' && \    
    julia -e 'import Pkg; Pkg.add("TextAnalysis"); using TextAnalysis' && \    
    # julia -e 'import Pkg; Pkg.add("ODBC"); using ODBC' && \    
    julia -e 'import Pkg; Pkg.add("Joseki"); using Joseki' && \    
    julia -e 'import Pkg; Pkg.add("Genie"); using Genie' && \    
    julia -e 'import Pkg; Pkg.add("ZMQ"); using ZMQ' && \    
    julia -e 'import Pkg; Pkg.add("JuliaWebAPI"); using JuliaWebAPI' && \    
    julia -e 'import Pkg; Pkg.add("ProtoBuf"); using ProtoBuf' && \    
    julia -e 'import Pkg; Pkg.add("HTTP"); using HTTP' && \    
    julia -e 'import Pkg; Pkg.add("Bukdu"); using Bukdu' && \    
    julia -e 'import Pkg; Pkg.add("Diana"); using Diana' && \    
    julia -e 'import Pkg; Pkg.add("WebSockets"); using WebSockets' && \    
    julia -e 'import Pkg; Pkg.add("MbedTLS"); using MbedTLS' && \    
    julia -e 'import Pkg; Pkg.add("PackageCompiler"); using PackageCompiler' && \    
    fix-permissions /home/$NB_USER

# RUN julia -e 'import Pkg; Pkg.add("CmdStan"); using CmdStan' && \    
    # julia -e 'import Pkg; Pkg.add("Cairo"); using Cairo' && \ 

#  USER root
#  RUN apt-get install libcairo2 zlib1g
#  USER $NB_UID 

#  RUN julia -e 'import Pkg; Pkg.add("CmdStan"); using CmdStan' && \    
#  RUN julia -e 'import Pkg; Pkg.add("BinDeps"); using BinDeps' && \    
#     julia -e 'import Pkg; Pkg.add(Pkg.PackageSpec(url="https://github.com/giordano/Cairo.jl.git#binary-builder")); Pkg.build(Cairo); using Cairo' && \ 
#         fix-permissions /home/$NB_USER

 RUN julia -e 'import Pkg; Pkg.add("Dierckx"); using Dierckx' && \  
    fix-permissions /home/$NB_USER
    

 RUN julia -e 'import Pkg; Pkg.add("DiffEqParamEstim"); using DiffEqParamEstim' && \  
    # julia -e 'import Pkg; Pkg.add("DiffEqBayes"); using DiffEqBayes' && \    
    julia -e 'import Pkg; Pkg.add("RecursiveArrayTools"); using RecursiveArrayTools' && \   
    julia -e 'import Pkg; Pkg.add("ParameterizedFunctions"); using ParameterizedFunctions' && \   
    fix-permissions /home/$NB_USER

# RUN julia -e 'import Pkg; Pkg.update(); Pkg.up();'

RUN julia -e 'import Pkg; Pkg.update(); Pkg.resolve()' && \
    julia -e 'import Pkg; Pkg.add("Distributions"); using Distributions' && \   
    # julia -e 'import Pkg; Pkg.add("Mamba"); using Mamba' && \   
    # julia -e 'import Pkg; Pkg.add("CmdStan"); using CmdStan' && \    
    julia -e 'import Pkg; Pkg.add(Pkg.PackageSpec(url="https://github.com/brian-j-smith/Mamba.jl")); using Mamba' && \ 
    # julia -e 'import Pkg; Pkg.add("DiffEqBayes"); using DiffEqBayes' && \    
    julia -e 'import Pkg; Pkg.add(Pkg.PackageSpec(url="https://github.com/probcomp/Gen")); using Gen' && \    
    julia -e 'import Pkg; Pkg.add("Turing"); using Turing' && \   
    # julia -e 'import Pkg; Pkg.add("ParameterizedFunctions"); using ParameterizedsFunctions' && \   
    fix-permissions /home/$NB_USER

RUN julia -e 'import Pkg; Pkg.update(); Pkg.resolve()' && \
    julia -e 'import Pkg; Pkg.add("DiffEqFlux"); using DiffEqFlux' && \   
    julia -e 'import Pkg; Pkg.add("StatsPlots"); using StatsPlots' && \ 
    julia -e 'import Pkg; Pkg.add("Tracker"); using Tracker' && \   
    julia -e 'import Pkg; Pkg.add("DiffResults"); using DiffResults' && \  
    julia -e 'import Pkg; Pkg.add("ForwardDiff"); using ForwardDiff' && \   
    julia -e 'import Pkg; Pkg.add("Requires"); using Requires' && \   
    julia -e 'import Pkg; Pkg.add("RecursiveArrayTools"); using RecursiveArrayTools' && \   
    julia -e 'import Pkg; Pkg.add("Adapt"); using Adapt' && \ 
    julia -e 'import Pkg; Pkg.add("DiffEqSensitivity"); using DiffEqSensitivity' && \   
    julia -e 'import Pkg; Pkg.add("LinearAlgebra"); using LinearAlgebra' && \   
    julia -e 'import Pkg; Pkg.add("DataFrames"); using DataFrames' && \   
    julia -e 'import Pkg; Pkg.add("DataFramesMeta"); using DataFramesMeta' && \   
    julia -e 'import Pkg; Pkg.add("Query"); using Query' && \   
    # julia -e 'import Pkg; Pkg.add(PackageSpec(url="https://github.com/baggepinnen/FluxOptTools")); using FluxOptTools' && \    
    fix-permissions /home/$NB_USER

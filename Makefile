# programs
ECHO   = @echo
RM     = @rm -rf
GCC    = @gcc

# shader
SHADER_C = @shader -q
SHADERARGS = `echo :${RMAN_SHADER_PATH}:@ | sed "s/:/ -I/g" `

SHADER_SRC  = $(wildcard *.sl)
SHADER_SLO  = $(patsubst %.sl, %.slo, $(SHADER_SRC))
SHADER_DEPS = $(patsubst %.sl, %.d, $(SHADER_SRC))

%.d : %.sl
	$(ECHO) "Finding dependencies for $<."
	$(GCC) $(SHADERARGS) -c -MM -x c $< -MT $(patsubst %.sl, %.slo, $<) -MF $@

%.slo : %.sl 
	$(ECHO) "Compiling: $@"
	$(SHADER_C) $(SHADERARGS) -o $@ $< 

all: $(SHADER_SLO)

clean:
	$(RM) *.slo
	$(RM) $(SHADER_DEPS)
	$(ECHO) "cleaned."

help: 
	$(ECHO) $(TARGETS)

ifneq "$(MAKECMDGOALS)" "clean"
    # Include the list of dependancies generated for each object file
    -include $(SHADER_DEPS)
 endif


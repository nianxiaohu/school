#include <stdio.h>
#include <stdlib.h>
int main(int argc, char **argv, char **envp) 
{
  int i=0;
  printf("Command line arguments:\n");
  while ( i < argc)
    {
      printf("argv[ %d]: %s\n",i,argv[i]);
      i++;
    }
  printf("Environment variables:\n");
  i = 0;
  while (envp[i])
    {
      printf("envp[ %d]: %s\n",i,envp[i]);
      i++;
    }
  exit(0);
}

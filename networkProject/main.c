#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include "mtwist.h"
struct node { 
  int a;
  int link;
};
struct node *initialNode;
struct node *traverseNode;
int nodeNumber;
int maxdepth;
float probability;
int *indegreeTable;
int *indegreeDistribution;
int *maxdepthTable;
int rootNode;
int networkSetup();
int main(void) {
  FILE *ofp;
  char *mode = "w";
  char outputFileName[] = "output.txt";
  ofp = fopen(outputFileName,mode);
  if(ofp == NULL) {
    fprintf(stderr, "Can't open output file%s!\n",outputFileName);
    exit(1);
  }
  while(1)
    {
      int i;
      errno = 0;
      printf("Enter nodeNumber copyProbability:\n");
      i = scanf("%d%f",&nodeNumber,&probability);
      if ( i == 2){
	printf("Create a random network with %d nodes and copy probility %f\n",nodeNumber,probability);
      } else if ( errno != 0) {
	perror("scanf");
      } else {
	fprintf(stderr,"No matching inputs\n");
      }
      if ( networkSetup()){
	fprintf(stderr,"networkSetup\n"); 
	return -1;
      }
      /* traverseNode = initialNode;
      i = 0;
      while(traverseNode && i<nodeNumber){
	printf("Node %d points to %d\n",traverseNode->a,traverseNode->link);
	traverseNode++;
	i++;
	}*/
      printf("MaxDepth is %d\n",maxdepth);
      i=0;
      for(;i<nodeNumber;i++) 
	{
	  if(indegreeDistribution[i])
	    {
	      printf("Hello\n");
	      fprintf(ofp,"%d %d\n",indegreeDistribution[i],i);
	    }
	}
      traverseNode = &initialNode[rootNode];
      i=0;
      printf("%d",traverseNode->a);
      traverseNode = &initialNode[traverseNode->link];
      while(traverseNode && i<maxdepth) {
	printf("----%d",traverseNode->a);
	traverseNode = &initialNode[traverseNode->link];
	i++;
      }
      printf("\n\n\n");
      free(initialNode);
      free(indegreeTable);
      free(indegreeDistribution);
      free(maxdepthTable);
    }
  fclose(ofp);
  return 0;
}
int networkSetup() {
  int j;
  int random1;
  double random2;
  struct node *currentNode;
  struct node *prevNode;
  printf("networkSetup\n");
  if( !(initialNode = malloc(sizeof(struct node)*nodeNumber))){
    perror("malloc");
  }
  if( !(indegreeTable = malloc(sizeof(int)*nodeNumber))){
    perror("malloc");
  }
  if( !(indegreeDistribution = malloc(sizeof(int)*nodeNumber))){
    perror("malloc");
  }
  if( !(maxdepthTable = malloc(sizeof(int)*nodeNumber))){
    perror("malloc");
  }

  for(j=0;j<nodeNumber;j++)
    {
      indegreeTable[j]=0;
      indegreeDistribution[j]=0;
      maxdepthTable[j]=0;
    }
  initialNode->a = 0;
  initialNode->link = 0;
  currentNode = initialNode;
  prevNode = initialNode;
  mt_seed();
  for (j=1; j<nodeNumber; j++) {
    random1 = mt_llrand()%j;
    random2 = mt_ldrand();
    prevNode = currentNode;
    currentNode++;
    currentNode->a = j;
    if (probability <= random2)
      {
	currentNode->link = random1;
	indegreeTable[random1]++;
      }
    else
      {
	currentNode->link = (initialNode+random1)->link;
	indegreeTable[currentNode->link]++;
      }
  }
  j=0;
  for(;j<nodeNumber;j++) {
    indegreeDistribution[indegreeTable[j]]++;
  }
  maxdepth=0;
  maxdepthTable[0]=0;
  j=0;
  j++;
  rootNode = 0;
  traverseNode = initialNode;
  for(;j<nodeNumber;j++) {
    traverseNode++;
    maxdepthTable[j]=maxdepthTable[traverseNode->link]+1;
    if (maxdepth < maxdepthTable[j])
      {
	maxdepth = maxdepthTable[j];
	rootNode = j;
      }
  }
  return 0;
}

#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <math.h>
#include "mtwist.h"
struct node { 
  int a;
  int link;
};
struct node *initialNode;
int networkSetup(int,double);
int main(void) {
  while(1)
    {
      int n;
      float p;
      int i;
      struct node *traverseNode;
      errno = 0;
      i = scanf("%d%f",&n,&p);
      if ( i == 2){
	printf("To create a random network with %d nodes and probility %f\n",n,p);
      } else if ( errno != 0) {
	perror("scanf");
      } else {
	fprintf(stderr,"No matching inputs\n");
      }
      if ( networkSetup(n,p)){
	fprintf(stderr,"networkSetup\n"); 
	return -1;
      }
      traverseNode = initialNode;
      i = 1;
      while(traverseNode && i<=n){
	printf("Node %d points to %d\n",traverseNode->a,traverseNode->link);
	traverseNode++;
	i++;
      }
    }

  return 0;
}
int networkSetup(int nodeNumber, double probability) {
  int j;
  int random1;
  double random2;
  struct node *currentNode;
  struct node *prevNode;
  int temp;
  printf("networkSetup\n");
  if( !(initialNode = malloc(sizeof(struct node)*nodeNumber))){
    perror("malloc");
  }
  initialNode->a = 1;
  initialNode->link = 1;
  currentNode = initialNode;
  prevNode = initialNode;
  mt_seed();
  for (j=2; j<=nodeNumber; j++) {
    temp = abs(mt_lrand());
    random1 = temp%(j-1)+1;
    random2 = mt_drand();
    prevNode = currentNode;
    currentNode++;
    currentNode->a = j;
    if (probability <= random2)
      currentNode->link = random1;
    else{
      currentNode->link = (initialNode+random1-1)->link;
    }
  }
  return 0;
}

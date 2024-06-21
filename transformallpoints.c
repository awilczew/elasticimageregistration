/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: transformallpoints.c
 *
 * MATLAB Coder version            : 3.2
 * C/C++ source code generated on  : 05-Oct-2017 15:03:56
 */

/* Include Files */
#include "tmwtypes.h"
//#include "rt_nonfinite.h"
#include "transformallpoints2.h"

#include "matrix.h"
#include "mex.h"

/* Function Definitions */

/*
 * UNTITLED2 Summary of this function goes here
 *    Detailed explanation goes here
 * Arguments    : const double nodes[8232]
 *                const struct0_T *glob
 *                double n
 *                double m
 *                double itmax
 *                const double image[8200192]
 *                double b_y1[8200192]
 *                double y2[8200192]
 *                double y3[8200192]
 * Return Type  : void
 */
void transformallpoints(double *nodes, int
  n, int m,  unsigned int itmax, double *x2,
  double *y2,  int xsize,int ysize)
{
  
  unsigned int iter;
  unsigned int ix;
  unsigned int iy;
  double a[4];
  double b[4];
  int i,j;
  unsigned int k,l;
  double fact;
  int *ia,*ja;
  double ua,va,*Bu0,*Bu1,*Bu2,*Bu3,*Bv0,*Bv1,*Bv2,*Bv3,x,y;
  ia = (int*)mxMalloc(xsize* sizeof(int));
  ja = (int*)mxMalloc(ysize* sizeof(int));

  Bu0 = (double*)mxMalloc(xsize* sizeof(double)); 
  Bu1 = (double*)mxMalloc(xsize* sizeof(double)); 
  Bu2 = (double*)mxMalloc(xsize* sizeof(double)); 
  Bu3 = (double*)mxMalloc(xsize* sizeof(double)); 
  Bv0 = (double*)mxMalloc(ysize* sizeof(double)); 
  Bv1 = (double*)mxMalloc(ysize* sizeof(double)); 
  Bv2 = (double*)mxMalloc(ysize* sizeof(double)); 
  Bv3 = (double*)mxMalloc(ysize* sizeof(double)); 

  for(i=0;i<xsize;i++){
     x=((double)m-3.0)-(1.0+(((double)m-5)/((double)xsize-1.0))*((double)i));
   
     ia[i]=floor(x)-1;
     ua=x-floor(x);
     Bu0[i]=((double)pow(1-ua,3))/6;
     Bu1[i]=((double)(3*pow(ua,3)-6*pow(ua,2)+4))/6;
     Bu2[i]=((double)(-3*pow(ua,3)+3*pow(ua,2)+3*ua+1))/6;
     Bu3[i]=((double)(pow(ua,3)))/6; 
     
  }
  for(i=0;i<ysize;i++){
     y=1.0+((double)(n-5)/((double)ysize-1))*((double)i);
     ja[i]=floor(y)-1;
     va=y-floor(y);
     Bv0[i]=((double)pow(1-va,3))/6;
     Bv1[i]=((double)(3*pow(va,3)-6*pow(va,2)+4))/6;
     Bv2[i]=((double)(-3*pow(va,3)+3*pow(va,2)+3*va+1))/6;
     Bv3[i]=((double)(pow(va,3)))/6;  
  }

  i=0;
  memset(&x2[0], 0, itmax * sizeof(double));
  memset(&y2[0], 0, itmax * sizeof(double));


  for (iter = 0; iter < itmax; iter++) {

    ix = (int)floor((double)(( iter)/ysize + 1.0)) - 1;
    iy = iter -  (ix) * ysize;

    /* wyznaczenie nowych wsp??rz?dnych punktu */
    a[0] = Bu0[ix];
    a[1] = Bu1[ix];
    a[2] = Bu2[ix];
    a[3] = Bu3[ix];
    b[0] = Bv0[iy];
    b[1] = Bv1[iy];
    b[2] = Bv2[iy];
    b[3] = Bv3[iy];

    i = ia[ix];
    j = ja[iy];

   
    for (k = 0; k < 4; k++) {
      for (l = 0; l < 4; l++) {
          fact = a[k] * b[l];
          
          x2[iter] += fact * nodes[((((l + j) + 2) + n * ((m
            - (i + k)) - 2)))- 1];
 
          y2[iter] += fact * nodes[((((j + l) + 2) + n * ((m -
            (i + k)) - 2))) +n*m-1];

      }
    } 
  }
  mxFree(Bu0);
  mxFree(Bu1);
  mxFree(Bu2);
  mxFree(Bu3);
  mxFree(Bv0);
  mxFree(Bv1);
  mxFree(Bv2);
  mxFree(Bv3);
  mxFree(ia);mxFree(ja);
}

/*
 * File trailer for transformallpoints.c
 *
 * [EOF]
 */
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[] )
{
    /* Ox and Oy are the grid points */
    /* Zo is the input image */
    /* Zi is the transformed image */

    /* nx and ny are the number of grid points (inside the image) */
    double *nodes,n,m,*x2,*y2,xsize,ysize;
    
   unsigned int itmax;

  /* Check for proper number of arguments. */
  if(nrhs!=5) {
    mexErrMsgTxt("five inputs are required.");
  }


  /* Assign pointers to each input. */
  nodes=(double *)mxGetPr(prhs[0]);
  n=*(double *)mxGetPr(prhs[1]);
  m=*(double *)mxGetPr(prhs[2]);
  xsize=*(double *)mxGetPr(prhs[3]);
  ysize=*(double *)mxGetPr(prhs[4]);

  
   itmax=(unsigned int)((unsigned int)xsize*(unsigned int)ysize);
   
   x2 = (double*)mxMalloc(itmax* sizeof(double)); 
   y2 = (double*)mxMalloc(itmax* sizeof(double)); 
  
  
  plhs[0]=mxCreateDoubleMatrix((mwSize)itmax,1,mxREAL);
  plhs[1]=mxCreateDoubleMatrix((mwSize)itmax,1,mxREAL);


   x2 =mxGetPr(plhs[0]); 
   y2=mxGetPr(plhs[1]); 


transformallpoints(nodes, (int)n, (int)m, itmax, x2,y2, (int)xsize,(int)ysize);



return;
}



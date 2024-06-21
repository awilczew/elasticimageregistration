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
#include "penalties.h"
#include "stdlib.h"
#include "matrix.h"
#include "math.h"
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
void volumetransform(double *nodes, int
  n, int m,  unsigned int itmax, int xsize,int ysize,
        double *vpenalty, double *spenalty)
{
  
  unsigned int iter;
  unsigned int ix;
  unsigned int iy;
  double a[4], da[4],da2[4];
  double b[4],db[4],db2[4];
  int i,j;
  unsigned int k,l;
  double fact;
  int *ia,*ja;
  double ua,va,*Bu0,*Bu1,*Bu2,*Bu3,*Bv0,*Bv1,*Bv2,*Bv3,x,y;
  double *dBu0,*dBu1,*dBu2,*dBu3,*dBv0,*dBv1,*dBv2,*dBv3;
  double *dB2u0, *dB2u1,*dB2u2, *dB2u3,*dB2v0,*dB2v1,*dB2v2,*dB2v3;
  double txx,txy,tyx,tyy,txxx,tyyy,txxy;
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
  
  dBu0 = (double*)mxMalloc(xsize* sizeof(double)); 
  dBu1 = (double*)mxMalloc(xsize* sizeof(double)); 
  dBu2 = (double*)mxMalloc(xsize* sizeof(double)); 
  dBu3 = (double*)mxMalloc(xsize* sizeof(double)); 
  dBv0 = (double*)mxMalloc(ysize* sizeof(double)); 
  dBv1 = (double*)mxMalloc(ysize* sizeof(double)); 
  dBv2 = (double*)mxMalloc(ysize* sizeof(double)); 
  dBv3 = (double*)mxMalloc(ysize* sizeof(double)); 
  
  dB2u0 = (double*)mxMalloc(xsize* sizeof(double)); 
  dB2u1 = (double*)mxMalloc(xsize* sizeof(double)); 
  dB2u2 = (double*)mxMalloc(xsize* sizeof(double)); 
  dB2u3 = (double*)mxMalloc(xsize* sizeof(double)); 
  dB2v0 = (double*)mxMalloc(ysize* sizeof(double)); 
  dB2v1 = (double*)mxMalloc(ysize* sizeof(double)); 
  dB2v2 = (double*)mxMalloc(ysize* sizeof(double)); 
  dB2v3 = (double*)mxMalloc(ysize* sizeof(double)); 


  for(i=0;i<xsize;i++){
     x=((double)m-3.0)-(1.0+(((double)m-5)/((double)xsize-1.0))*((double)i));
   
     ia[i]=floor(x)-1;
     ua=x-floor(x);
     Bu0[i]=((double)pow(1-ua,3))/6;
     Bu1[i]=((double)(3*pow(ua,3)-6*pow(ua,2)+4))/6;
     Bu2[i]=((double)(-3*pow(ua,3)+3*pow(ua,2)+3*ua+1))/6;
     Bu3[i]=((double)(pow(ua,3)))/6; 
     dBu0[i]=((double)(-pow(ua,2)+2*ua-1))/2;
     dBu1[i]=((double)(3*pow(ua,2)-4*ua))/2;
     dBu2[i]=((double)(-3*pow(ua,2)+2*ua+1))/2;
     dBu3[i]=((double)(pow(ua,2)))/2; 
     dB2u0[i]=((double)(-ua+1));
     dB2u1[i]=((double)(3*ua-2));
     dB2u2[i]=((double)(-3*ua+1));
     dB2u3[i]=((double)(ua));
     
  }
  for(i=0;i<ysize;i++){
     y=1.0+((double)(n-5)/((double)ysize-1))*((double)i);
     ja[i]=floor(y)-1;
     va=y-floor(y);
     Bv0[i]=((double)pow(1-va,3))/6;
     Bv1[i]=((double)(3*pow(va,3)-6*pow(va,2)+4))/6;
     Bv2[i]=((double)(-3*pow(va,3)+3*pow(va,2)+3*va+1))/6;
     Bv3[i]=((double)(pow(va,3)))/6;
     dBv0[i]=((double)(-pow(va,2)+2*va-1))/2;
     dBv1[i]=((double)(3*pow(va,2)-4*va))/2;
     dBv2[i]=((double)(-3*pow(va,2)+2*va+1))/2;
     dBv3[i]=((double)(pow(va,2)))/2; 
     dB2v0[i]=((double)(-va+1));
     dB2v1[i]=((double)(3*va-2));
     dB2v2[i]=((double)(-3*va+1));
     dB2v3[i]=((double)(va));
  }

  i=0;

  double nodex=0,nodey=0;

  for (iter = 0; iter < itmax; iter++) {

    ix = (int)floor((double)(( iter)/ysize + 1.0)) - 1;
    iy = iter -  (ix) * ysize;

    /* wyznaczenie nowych wsp??rz?dnych punktu */
    a[0] = Bu0[ix];a[1] = Bu1[ix];a[2] = Bu2[ix];a[3] = Bu3[ix];
    b[0] = Bv0[iy];b[1] = Bv1[iy];b[2] = Bv2[iy];b[3] = Bv3[iy];
    da[0] = dBu0[ix];da[1] = dBu1[ix];da[2] = dBu2[ix];da[3] = dBu3[ix];
    db[0] = dBv0[iy];db[1] = dBv1[iy];db[2] = dBv2[iy];db[3] = dBv3[iy];
    da2[0] = dB2u0[ix];da2[1] = dB2u1[ix];da2[2] = dB2u2[ix];da2[3] = dB2u3[ix];
    db2[0] = dB2v0[iy];db2[1] = dB2v1[iy];db2[2] = dB2v2[iy];db2[3] = dB2v3[iy];
    i = ia[ix];
    j = ja[iy];

    
    txx=0;txy=0;tyx=0;tyy=0;txxx=0;tyyy=0;txxy=0;
    for (k = 0; k < 4; k++) {
      for (l = 0; l < 4; l++) {
          nodex=nodes[((((l + j) + 2) + n * ((m- (i + k)) - 2)))- 1];
          nodey=nodes[((((j + l) + 2) + n * ((m -(i + k)) - 2))) +n*m-1];
          
          txx += da[k]*b[l] * nodex;
//           txx+=j;
          txy += a[k]*db[l] * nodex;
          tyx += da[k]*b[l] * nodey;
          tyy += a[k]*db[l] * nodey;
          txxx += (da2[k]*b[l]*(nodex+nodey));
          tyyy += (a[k]*db2[l]*(nodey+nodex));
          txxy += (da[k]*db[l]*(nodey+nodex));

      }
    } 
    if((txx*tyy-tyx*txy)!=0){
        vpenalty[iter]=abs(log(txx*tyy-tyx*txy));   
    }else{
        vpenalty[iter]=0;
    }

     spenalty[iter]=pow(txxx,2)+pow(tyyy,2)+2*pow(txxy,2);
//     vpenalty[iter]=txx;
//     spenalty[iter]=txxx;
  }
  mxFree(Bu0);
  mxFree(Bu1);
  mxFree(Bu2);
  mxFree(Bu3);
  mxFree(Bv0);
  mxFree(Bv1);
  mxFree(Bv2);
  mxFree(Bv3);
  mxFree(dBu0);
  mxFree(dBu1);
  mxFree(dBu2);
  mxFree(dBu3);
  mxFree(dBv0);
  mxFree(dBv1);
  mxFree(dBv2);
  mxFree(dBv3);
  mxFree(dB2u0);
  mxFree(dB2u1);
  mxFree(dB2u2);
  mxFree(dB2u3);
  mxFree(dB2v0);
  mxFree(dB2v1);
  mxFree(dB2v2);
  mxFree(dB2v3);
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
    double *nodes,n,m,*vpenalty, *spenalty,xsize,ysize;
    
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
   vpenalty = (double*)mxMalloc(itmax* sizeof(double)); 
   spenalty = (double*)mxMalloc(itmax* sizeof(double)); 

   
  plhs[0]=mxCreateDoubleMatrix((mwSize)itmax,1,mxREAL);
  plhs[1]=mxCreateDoubleMatrix((mwSize)itmax,1,mxREAL);

  
   vpenalty =mxGetPr(plhs[0]); 
   spenalty =mxGetPr(plhs[1]); 



volumetransform(nodes, (int)n, (int)m, itmax,(int)xsize,(int)ysize,
        vpenalty, spenalty);



return;
}



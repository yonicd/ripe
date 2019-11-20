testthat::context("basic functionality")

testthat::describe('ripe',{
  
  it('rerun once',{
    testthat::expect_length(stats::runif(20)%>%sample(4)%>%ripe(replicate,n=1,simplify=FALSE),1)
  })
  
  it('rerun more thanonce',{
    testthat::expect_length(stats::runif(20)%>%sample(4)%>%ripe(replicate,n=3,simplify=FALSE),3)
  })
  
  it('rerun apply',{
    testthat::expect_length(stats::runif(20)%>%sample(4)%>%ripe(lapply, X=1:4),4)
  })
})

testthat::describe('lazy',{
  
  f <- stats::runif(20)%>%
    sample(10)%>%
    utils::head(5)%>%
    lazy()
  
  it('class',{
    testthat::expect_true(inherits(f,'function'))
  })
  
  it('legnth',{
    testthat::expect_length(f(),5)
  })
  
})
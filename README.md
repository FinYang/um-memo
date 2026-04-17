# Quarto memo template with Maastricht University title block

- This is an unofficial template that is not endorsed by the university or the school. 
- The title block background photos were taken by the author and is not endorsed by the university or the school.
- Modified from [`quarto-monash/memo`](https://github.com/quarto-monash/memo). 


## Installing


```bash
quarto use template FinYang/um-memo
```

This will install the extension and create an example qmd file that you can use as a starting place for your article.

## Aspect ratio


There are two versions of the template, one using LaTeX (`um-memo-pdf`), and one using Typst (`um-memo-typst`)

``` yaml
format: um-memo-typst # Use um-memo-pdf to use latex
```

To remove title block branding, set
``` yaml
branding: false
```

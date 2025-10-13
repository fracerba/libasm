/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_lstadd_front.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: fracerba <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/10/21 15:13:59 by fracerba          #+#    #+#             */
/*   Updated: 2022/10/21 15:14:01 by fracerba         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../libasm.h"

void    ft_list_sort(t_list **begin_list, int (*cmp)())
{
    t_list	*tmp;
    t_list  *next;

	if (!begin_list || !*begin_list || !(*begin_list)->next || !cmp)
        return ;
    tmp = *begin_list;

    while (tmp)
    {
        next = tmp -> next;
        while (next)
        {
            if (cmp(tmp->data, next->data) > 0)
            {
                void *swap = tmp->data;
                tmp->data = next->data;
                next->data = swap;
            }
            next = next -> next;
        }
        tmp = tmp -> next;
    }   
}